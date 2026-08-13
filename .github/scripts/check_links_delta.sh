#!/usr/bin/env bash

set -euo pipefail

if (( $# != 3 )); then
  echo "usage: $0 BASE_SHA HEAD_SHA CHANGED_DOCS_FILE" >&2
  exit 2
fi

base_sha=$1
head_sha=$2
changed_docs_file=$3
scratch=$(mktemp -d)
base_tree="$scratch/base"
head_tree="$scratch/head"
base_added=false
head_added=false

cleanup() {
  if [[ "$base_added" == true ]]; then
    git worktree remove --force "$base_tree" >/dev/null 2>&1 || true
  fi
  if [[ "$head_added" == true ]]; then
    git worktree remove --force "$head_tree" >/dev/null 2>&1 || true
  fi
  rm -rf "$scratch"
}
trap cleanup EXIT

git worktree add --detach --quiet "$head_tree" "$head_sha"
head_added=true
if git cat-file -e "${base_sha}^{commit}" 2>/dev/null; then
  git worktree add --detach --quiet "$base_tree" "$base_sha"
  base_added=true
fi

rename_from=()
rename_to=()
while IFS= read -r -d '' status; do
  case "$status" in
    R*)
      IFS= read -r -d '' old_path
      IFS= read -r -d '' new_path
      rename_from+=("$old_path")
      rename_to+=("$new_path")
      ;;
    *)
      IFS= read -r -d '' _path
      ;;
  esac
done < <(git diff --name-status -z --find-renames \
  "$base_sha" "$head_sha" -- '*.md')

base_path_for() {
  local head_path=$1
  local index

  for (( index = 0; index < ${#rename_to[@]}; index++ )); do
    if [[ "${rename_to[$index]}" == "$head_path" ]]; then
      printf '%s\n' "${rename_from[$index]}"
      return
    fi
  done
  printf '%s\n' "$head_path"
}

head_path_for() {
  local base_path=$1
  local index

  for (( index = 0; index < ${#rename_from[@]}; index++ )); do
    if [[ "${rename_from[$index]}" == "$base_path" ]]; then
      printf '%s\n' "${rename_to[$index]}"
      return
    fi
  done
  printf '%s\n' "$base_path"
}

changed_inputs=()
while IFS= read -r document; do
  [[ -n "$document" ]] || continue
  base_document=$(base_path_for "$document")
  changed_inputs+=("$head_tree/$document")
  if [[ "$base_added" == true && -f "$base_tree/$base_document" ]]; then
    changed_inputs+=("$base_tree/$base_document")
  fi
done < "$changed_docs_file"

local_inputs=()
while IFS= read -r -d '' document; do
  [[ "$document" == *.md ]] || continue
  base_document=$(base_path_for "$document")
  local_inputs+=("$head_tree/$document")
  if [[ "$base_added" == true && -f "$base_tree/$base_document" ]]; then
    local_inputs+=("$base_tree/$base_document")
  fi
done < <(git ls-tree -r -z --name-only "$head_sha")

normalize_findings() {
  local report=$1
  local tree_root=$2
  local output=$3
  local file_prefix="file://$tree_root"

  jq -r '
    (.error_map // {}), (.timeout_map // {})
    | to_entries[]
    | .key as $source
    | .value[]
    | [$source, .url]
    | @tsv
  ' "$report" |
    while IFS=$'\t' read -r source url; do
      [[ "$source" == "$tree_root/"* ]] || continue
      source=${source#"$tree_root/"}
      if [[ "$tree_root" == "$base_tree" ]]; then
        source=$(head_path_for "$source")
      fi
      if [[ "$url" == "$file_prefix"* ]]; then
        url="file://WORKTREE${url#"$file_prefix"}"
      fi
      printf '%s\t%s\n' "$source" "$url"
    done |
    sort > "$output"
}

compare_report() {
  local label=$1
  local report=$2
  local base_findings="$scratch/$label-base-findings.txt"
  local head_findings="$scratch/$label-head-findings.txt"
  local new_findings="$scratch/$label-new-findings.txt"

  : > "$base_findings"
  if [[ "$base_added" == true ]]; then
    normalize_findings "$report" "$base_tree" "$base_findings"
  fi
  normalize_findings "$report" "$head_tree" "$head_findings"
  comm -13 "$base_findings" "$head_findings" > "$new_findings"

  if [[ -s "$new_findings" ]]; then
    echo "$label introduces link-check findings:" >&2
    awk -F '\t' '{ printf "  %s: %s\n", $1, $2 }' "$new_findings" >&2
    return 1
  fi
}

run_check() {
  local label=$1
  local offline=$2
  shift 2
  local inputs=("$@")
  local options=(--format json --no-progress --exclude-all-private)
  local report="$scratch/$label-lychee.json"
  local result=0

  if (( ${#inputs[@]} == 0 )); then
    return 0
  fi
  if [[ "$offline" == true ]]; then
    options+=(--offline)
  fi

  lychee "${options[@]}" \
    --output "$report" -- "${inputs[@]}" || result=$?
  if (( result != 0 && result != 2 )); then
    echo "lychee failed before producing $label link-check results" >&2
    return "$result"
  fi
  if [[ ! -s "$report" ]]; then
    echo "lychee produced no $label link-check report" >&2
    return 1
  fi

  compare_report "$label" "$report"
}

failures=0
if (( ${#changed_inputs[@]} > 0 )); then
  run_check "Changed Markdown" false "${changed_inputs[@]}" || failures=1
fi
if (( ${#local_inputs[@]} > 0 )); then
  run_check "Repository-local links" true "${local_inputs[@]}" || failures=1
fi
exit "$failures"
