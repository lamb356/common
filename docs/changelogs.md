# Changelog policy

Every workspace crate ships a `CHANGELOG.md` (it is included in the published
package). The audience is a crates.io consumer of the `zakura-*` forks:
entries describe the crate's public API and observable behavior. Internal
implementation details, refactors, and CI changes do not belong in these
files; they live in commit messages and pull requests.

## Structure

Each changelog contains, in order:

1. A fixed header identifying the Keep a Changelog format and the
   public-API-only entry policy.
2. An `## About this fork` section — the permanent provenance seed. It names
   the upstream crate and version the fork began from, links the upstream
   repository and the exact upstream commit (taken from the
   `.cargo_vcs_info.json` of the published upstream artifact that was
   vendored), and records the commit in this repository that imported the
   code. For the crates that were ported between dependency stacks at import
   time, the seed says so.
3. An `## [Unreleased]` section where entries accumulate.
4. `## [x.y.z] - YYYY-MM-DD` sections, newest first.

The fork's version lineage restarts at `1.0.0`; it does not continue the
upstream numbering, and this file intentionally does not reproduce upstream
release history (the upstream repository remains the record for that).

## Cutting a release

Move the accumulated `## [Unreleased]` body into a new
`## [x.y.z] - YYYY-MM-DD` section directly beneath it, leaving the
`## [Unreleased]` heading in place with an empty body. Both the heading and
the `About this fork` section must always exist — CI checks for them.

## CI enforcement

`changelog.yml` enforces, for every workspace member:

- `CHANGELOG.md` contains an `## [Unreleased]` section and an
  `## About this fork` section at HEAD.
- A pull request that changes a member's `Cargo.toml` or any of its `.rs`
  files must also change something inside that member's `## [Unreleased]`
  body. Purely internal changes still require an entry decision: if a change
  is genuinely invisible to consumers, the convention is a one-line entry
  stating the visible effect (for example a performance statement), not a
  restatement of the implementation.

## Pending: initial `1.0.0` entries

The seeds deliberately start empty. Before the `1.0.0` release is tagged, a
reconstruction pass writes each crate's `## [1.0.0]` section describing the
public differences between the upstream fork point and the released fork:

1. For each crate, diff the current source against the upstream artifact
   recorded in its seed (`https://static.crates.io/crates/<name>/<name>-<version>.crate`).
2. Catalog only consumer-visible differences, in roughly this order:
   - the crate rename (`package = "zakura-*"`; library target names and
     therefore `use` paths are unchanged);
   - dependency major versions that appear in public signatures (the
     `ff`/`group` 0.14 stack, `rand_core` 0.10, the fork-internal
     replacements of `bellman`/`bls12_381`/`jubjub`/`pairing`/…);
   - added, removed, or changed public items and trait implementations;
   - added or removed cargo features and changed feature defaults;
   - MSRV (1.88) and edition (2024);
   - behavioral changes observable through the same API (performance
     characteristics worth a consumer's attention may be summarized in one
     line each).
3. Phrase entries for someone adapting code from the upstream crate to the
   fork, not for someone reviewing our development history.
