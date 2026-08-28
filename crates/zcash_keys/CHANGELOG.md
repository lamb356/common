# Changelog

All notable changes to this crate will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this crate adheres to Rust's notion of
[Semantic Versioning](https://semver.org/spec/v2.0.0.html). Entries describe
the crate's public API and observable behavior from a consumer's perspective;
internal implementation details are not tracked here.

## About this fork

`zakura-keys` is Zakura's fork of the upstream `zcash_keys` crate. This changelog
begins at the fork point: upstream history up to the fork is documented in the
upstream repository, and the fork's version lineage restarts at `1.0.0` rather
than continuing the upstream `0.16.1` numbering.

- Forked from: `zcash_keys 0.16.1`, published from
  [zcash/librustzcash](https://github.com/zcash/librustzcash) at commit
  [`cb356a7d`](https://github.com/zcash/librustzcash/commit/cb356a7def26d0bd8e1f21709951aeea137f58fa).
- Imported into this repository in commit `16d18d2a43d0aecdfcf9e9d02469c16ebf20e50b`.

## [Unreleased]

### Changed

- Renamed the package from `zcash_keys` to `zakura-keys`; the library target
  keeps its upstream name, so existing `use` paths compile unchanged.
- Replaced the upstream `orchard` dependency with the Zakura fork
  (`zakura-orchard` 1.0.0), whose types appear in this crate's API.
- Replaced the upstream `sapling-crypto` dependency with the Zakura fork
  (`zakura-sapling-crypto` 1.0.0), whose types appear in this crate's API.
- Raised the minimum supported Rust version from 1.88 to 1.91.
