# Changelog development artifacts

This directory stores the artifacts the workspace uses to record and track
changes between and across releases. It exists for development, review, and
release tooling — it is not user documentation. Crate consumers looking for
what changed in a release should read the `CHANGELOG.md` shipped inside each
crate (`crates/<name>/CHANGELOG.md`).

Contents:

- [`guidelines.md`](guidelines.md) — how and when to update the changelogs
  in this repository (policy).
- [`unreleased/`](unreleased/README.md) — one pending changelog fragment per
  pull request, consumed into the per-crate changelogs at release assembly.
