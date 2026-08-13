#!/usr/bin/env bash

set -euo pipefail

repo_root=$(git rev-parse --show-toplevel)
helper="$repo_root/.github/scripts/check_markdown_delta.sh"
config="$repo_root/.github/markdownlint.yml"
scratch=$(mktemp -d)
trap 'rm -rf "$scratch"' EXIT
fixture="$scratch/repository"
changed_docs="$scratch/changed-docs.txt"

git init --quiet "$fixture"
git -C "$fixture" config user.email ci@example.invalid
git -C "$fixture" config user.name "CI fixture"
printf 'docs.md\n' > "$changed_docs"

printf '# Fixture\n\nParagraph.\n\n\nTrailing paragraph.\n' > "$fixture/docs.md"
git -C "$fixture" add docs.md
git -C "$fixture" commit --quiet -m base
base_sha=$(git -C "$fixture" rev-parse HEAD)

printf '# Fixture\n\nParagraph.\n\n\nTrailing paragraph.\n\nChanged text.\n' > "$fixture/docs.md"
git -C "$fixture" commit --quiet -am baseline
baseline_sha=$(git -C "$fixture" rev-parse HEAD)

(
  cd "$fixture"
  bash "$helper" "$base_sha" "$baseline_sha" "$config" "$changed_docs"
)

printf '# Fixture\n\nParagraph.\n\n\nTrailing paragraph.\n\nChanged text.\n\n\nNew paragraph.\n' > "$fixture/docs.md"
git -C "$fixture" commit --quiet -am regression
regression_sha=$(git -C "$fixture" rev-parse HEAD)

if (
  cd "$fixture"
  bash "$helper" "$baseline_sha" "$regression_sha" "$config" "$changed_docs"
) > "$scratch/regression.log" 2>&1; then
  echo "Markdown delta policy accepted a newly introduced finding" >&2
  exit 1
fi

if ! grep -q 'introduces markdownlint findings' "$scratch/regression.log"; then
  cat "$scratch/regression.log" >&2
  echo "Markdown delta policy failed for an unexpected reason" >&2
  exit 1
fi
