# Changelog

All notable changes to this crate will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this crate adheres to Rust's notion of
[Semantic Versioning](https://semver.org/spec/v2.0.0.html). Entries describe
the crate's public API and observable behavior from a consumer's perspective;
internal implementation details are not tracked here.

## [Unreleased]

## [1.0.1] - 2026-08-29

### Changed

- Moved the repository from zakura-core/libraries to zakura-core/common;
  crate metadata and the packaged README now point at the new URL
  ([#266](https://github.com/zakura-core/common/pull/266)).

## [1.0.0] - 2026-08-28

### Changed

- Renamed the package from `bellman` to `zakura-bellman`; the library target
  keeps its original name, so existing `use` paths compile unchanged.
- Updated `ff` and `group` from 0.13 to 0.14 and `rand_core` from 0.6 to 0.10;
  RNG parameters in the parameter-generation, proving, and batch-verification
  APIs are now bound on `rand_core::Rng` instead of `RngCore`, and the
  `multiexp` signatures name the affine type as `<G as Curve>::Affine` in place
  of `<G as PrimeCurve>::Affine`, following the associated type's move from
  `PrimeCurve` to `Curve` in `group` 0.14.
- Replaced the `pairing` dependency with `zakura-pairing` 1.0.0, whose types
  appear in this crate's API.
- Stopped emitting `log` records under the `multicore` feature; the
  deadlock-guard message in `multicore::Waiter::wait` now prints to standard
  error before the panic instead of being logged.
- Raised the minimum supported Rust version to 1.91 and migrated the crate to
  the 2024 edition.

## Record of Fork

`zakura-bellman` began as a fork of the `bellman` crate and has been developed
independently in this repository since. This changelog starts at the fork
point: history up to that point is documented in the repository the code was
forked from, and this crate's version lineage restarted at `1.0.0` rather than
continuing the original `0.14.0` numbering.

- Forked from: `bellman 0.14.0`, published from
  [zkcrypto/bellman](https://github.com/zkcrypto/bellman) at commit
  [`e1377750`](https://github.com/zkcrypto/bellman/commit/e137775023a647716793a362ace008e058679b2a).
- Imported into this repository in commit `7f4d4d0d9ad4ef7af62196403570bdf3ca3718e8`.
- The import also ported the crate from the `ff`/`group` 0.13 stack it
  was forked with to `ff`/`group` 0.14.
