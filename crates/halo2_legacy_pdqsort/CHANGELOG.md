# Changelog

All notable changes to this crate will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this crate adheres to Rust's notion of
[Semantic Versioning](https://semver.org/spec/v2.0.0.html). Entries describe
the crate's public API and observable behavior from a consumer's perspective;
internal implementation details are not tracked here.

## [Unreleased]

### Changed

- Renamed the package from `halo2_legacy_pdqsort` to
  `zakura-halo2-legacy-pdqsort`; the library target keeps its original name, so
  existing `use` paths compile unchanged.
- Raised the minimum supported Rust version to 1.91 and migrated the crate to
  the 2024 edition.

## Record of Fork

`zakura-halo2-legacy-pdqsort` began as a fork of the `halo2_legacy_pdqsort`
crate and has been developed independently in this repository since. This
changelog starts at the fork point: history up to that point is documented in
the repository the code was forked from, and this crate's version lineage
restarted at `1.0.0` rather than continuing the original `0.1.0` numbering.

- Forked from: `halo2_legacy_pdqsort 0.1.0`, published from
  [zcash/halo2_legacy_pdqsort](https://github.com/zcash/halo2_legacy_pdqsort) at commit
  [`c3b69083`](https://github.com/zcash/halo2_legacy_pdqsort/commit/c3b69083adcc5ab63d02ffbbc716ee19bdcdc81f).
- Imported into this repository in commit `16d18d2a43d0aecdfcf9e9d02469c16ebf20e50b`.
