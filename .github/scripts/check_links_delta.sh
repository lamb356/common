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

inputs=()
while IFS= read -r document; do
  [[ -n "$document" ]] || continue
  inputs+=("$head_tree/$document")
  if [[ "$base_added" == true && -f "$base_tree/$document" ]]; then
    inputs+=("$base_tree/$document")
  fi
done < "$changed_docs_file"

if (( ${#inputs[@]} == 0 )); then
  exit 0
fi

report="$scratch/lychee.json"
result=0
lychee --format json --no-progress --exclude-all-private \
  --output "$report" "${inputs[@]}" || result=$?
if (( result != 0 && result != 2 )); then
  echo "lychee failed before producing link-check results" >&2
  exit "$result"
fi
if [[ ! -s "$report" ]]; then
  echo "lychee produced no link-check report" >&2
  exit 1
fi

normalize_findings() {
  local tree_root=$1
  local output=$2
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
      if [[ "$url" == "$file_prefix"* ]]; then
        url="file://WORKTREE${url#"$file_prefix"}"
      fi
      printf '%s\t%s\n' "$source" "$url"
    done |
    sort -u > "$output"
}

base_findings="$scratch/base-findings.txt"
head_findings="$scratch/head-findings.txt"
new_findings="$scratch/new-findings.txt"
: > "$base_findings"
if [[ "$base_added" == true ]]; then
  normalize_findings "$base_tree" "$base_findings"
fi
normalize_findings "$head_tree" "$head_findings"
comm -13 "$base_findings" "$head_findings" > "$new_findings"

if [[ -s "$new_findings" ]]; then
  echo "Changed Markdown introduces link-check findings:" >&2
  awk -F '\t' '{ printf "  %s: %s\n", $1, $2 }' "$new_findings" >&2
  exit 1
fi
