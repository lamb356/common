# Changelog

All notable changes to this crate will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this crate adheres to Rust's notion of
[Semantic Versioning](https://semver.org/spec/v2.0.0.html). Entries describe
the crate's public API and observable behavior from a consumer's perspective;
internal implementation details are not tracked here.

## About this fork

`zakura-primitives` is Zakura's fork of the upstream `zcash_primitives` crate. This changelog
begins at the fork point: upstream history up to the fork is documented in the
upstream repository, and the fork's version lineage restarts at `1.0.0` rather
than continuing the upstream `0.30.0` numbering.

- Forked from: `zcash_primitives 0.30.0`, published from
  [zcash/librustzcash](https://github.com/zcash/librustzcash) at commit
  [`57b844dc`](https://github.com/zcash/librustzcash/commit/57b844dc00bf1f25254b5859b8d5faa8e5730f98).
- Imported into this repository in commit `16d18d2a43d0aecdfcf9e9d02469c16ebf20e50b`.

## [Unreleased]

## [1.0.0] - 2026-08-28

### Changed

- Renamed the package from `zcash_primitives` to `zakura-primitives`; the
  library target keeps its upstream name, so existing `use` paths compile
  unchanged.
- Updated `ff` from 0.13 to 0.14 and `rand_core` from 0.6 to 0.10; RNG type
  parameters on the transaction builder's `build`, `build_for_pczt`, and
  `mock_build` methods now take the `Rng` trait bound in place of `RngCore`.
- Replaced the upstream `jubjub` dependency with the Zakura fork
  (`zakura-jubjub` 1.0.0), whose types appear in this crate's API.
- Replaced the upstream `orchard` dependency with the Zakura fork
  (`zakura-orchard` 1.0.0), whose types appear in this crate's API.
- Replaced the upstream `redjubjub` dependency with the Zakura fork
  (`zakura-redjubjub` 1.0.0).
- Replaced the upstream `sapling-crypto` dependency with the Zakura fork
  (`zakura-sapling-crypto` 1.0.0), whose types appear in this crate's API.
- Raised the minimum supported Rust version from 1.88 to 1.91.
