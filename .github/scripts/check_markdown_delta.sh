#!/usr/bin/env bash

set -euo pipefail

if (( $# != 4 )); then
  echo "usage: $0 BASE_SHA HEAD_SHA CONFIG CHANGED_DOCS_FILE" >&2
  exit 2
fi

base_sha=$1
head_sha=$2
config=$3
changed_docs_file=$4
scratch=$(mktemp -d)
trap 'rm -rf "$scratch"' EXIT
rename_map="$scratch/renames.txt"

git diff --name-status --find-renames --diff-filter=R \
  "$base_sha" "$head_sha" -- '*.md' > "$rename_map"

run_markdownlint() {
  local document=$1
  local normalized_output=$2
  local raw_output=$normalized_output.raw
  local result=0

  markdownlint --config "$config" "$document" > "$raw_output" 2>&1 || result=$?
  if (( result != 0 )) && ! grep -qE ' error MD[0-9]{3}' "$raw_output"; then
    cat "$raw_output" >&2
    return "$result"
  fi

  sed -E 's#^.*:[0-9]+(:[0-9]+)? error #error #' "$raw_output" |
    sort > "$normalized_output"
}

failures=0
index=0
while IFS= read -r document; do
  [[ -n "$document" ]] || continue
  index=$((index + 1))
  base_document="$scratch/base-$index.md"
  head_document="$scratch/head-$index.md"
  base_findings="$scratch/base-$index.txt"
  head_findings="$scratch/head-$index.txt"
  new_findings="$scratch/new-$index.txt"
  base_document_path=$document

  while IFS=$'\t' read -r status old_document new_document; do
    if [[ "$status" == R* && "$new_document" == "$document" ]]; then
      base_document_path=$old_document
      break
    fi
  done < "$rename_map"

  git show "$head_sha:$document" > "$head_document"
  run_markdownlint "$head_document" "$head_findings"

  if git cat-file -e "$base_sha:$base_document_path" 2>/dev/null; then
    git show "$base_sha:$base_document_path" > "$base_document"
    run_markdownlint "$base_document" "$base_findings"
    comm -13 "$base_findings" "$head_findings" > "$new_findings"
  else
    cp "$head_findings" "$new_findings"
  fi

  if [[ -s "$new_findings" ]]; then
    echo "$document introduces markdownlint findings:" >&2
    sed 's/^/  /' "$new_findings" >&2
    failures=1
  fi
done < "$changed_docs_file"

exit "$failures"
