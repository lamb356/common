---
name: changelog-fragment
description: >-
  Write the changelog fragment a pull request owns in this repository. Use
  when creating or updating a PR that changes Rust code or Cargo.toml, when
  the user mentions changelogs, release notes, or fragments, or when the
  "changelog fragment" CI check fails.
---

# Changelog fragments

Every PR that changes a Rust source file or any `Cargo.toml` owns exactly one
`docs/changelog/unreleased/<PR-number>.md` fragment. Never edit a crate's
`CHANGELOG.md` in an ordinary PR — pending notes live in fragments so that
concurrent PRs cannot conflict. The canonical policy is
`docs/changelog/guidelines.md`; the format reference is
`docs/changelog/unreleased/README.md`.

## Workflow

1. Create the fragment after the PR number exists (open the draft PR first).
2. Scope entries to crates by package name, categories beneath:

   ```markdown
   ## zakura-orchard

   ### Fixed

   - Fixed the consumer-visible behavior
     ([#123](https://github.com/zakura-core/libraries/pull/123)).
   ```

   Valid crate headings are the 17 workspace package names (`zakura-*`).
   Valid categories: `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`,
   `Security`. Prefer `Fixed` when unsure.
3. For internal-only changes (tests, refactors, CI) the fragment is still
   required, with an explicit exclusion:

   ```markdown
   <!-- changelog: none -->

   This PR only changes tests and has no crate-consumer-visible effect.
   ```

4. Validate locally: `./scripts/changelog.py check`.

## Writing entries

- Write for a crates.io consumer of the fork: the observable effect, not the
  implementation. Start each item with a verb and link the PR.
- The per-crate changelogs track public API and observable behavior only.
  A performance change gets one line about the visible effect.
- Do not describe undisclosed or unfixed vulnerabilities in `Security`
  entries.

## Exceptions

- Dependabot PRs are exempt.
- Release PRs (label `A-release`) must contain zero pending fragments; the
  release assembly consumes them (see the release-libraries skill).
- Until `1.0.0` ships the fragment requirement is inactive; the release
  branch curates the initial `## [1.0.0]` sections directly
  (`docs/changelog/guidelines.md`, "The 1.0.0 baseline").
