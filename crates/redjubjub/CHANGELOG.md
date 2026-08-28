# Changelog

All notable changes to this crate will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this crate adheres to Rust's notion of
[Semantic Versioning](https://semver.org/spec/v2.0.0.html). Entries describe
the crate's public API and observable behavior from a consumer's perspective;
internal implementation details are not tracked here.

## About this fork

`zakura-redjubjub` is Zakura's fork of the upstream `redjubjub` crate. This changelog
begins at the fork point: upstream history up to the fork is documented in the
upstream repository, and the fork's version lineage restarts at `1.0.0` rather
than continuing the upstream `0.8.0` numbering.

- Forked from: `redjubjub 0.8.0`, published from
  [ZcashFoundation/redjubjub](https://github.com/ZcashFoundation/redjubjub) at commit
  [`2f618e9b`](https://github.com/ZcashFoundation/redjubjub/commit/2f618e9b47617ae9d4112913391a5c3fbb8106f0).
- Imported into this repository in commit `a57d014096a67071a2c6522a160c7e0dfbeff0f4`.

## [Unreleased]

## [1.0.0] - 2026-08-28

### Changed

- Renamed the package from `redjubjub` to `zakura-redjubjub`; the library target
  keeps its upstream name, so existing `use` paths compile unchanged.
- Replaced the upstream `reddsa` dependency with the Zakura fork
  (`zakura-reddsa` 1.0.0), whose types appear in this crate's API.
- Updated `rand_core` from 0.6 to 0.10; the RNG parameters of `SigningKey::new`,
  `SigningKey::sign`, and `batch::Verifier::verify` are now bounded by `Rng +
  CryptoRng` instead of `RngCore + CryptoRng`.
- Raised the minimum supported Rust version to 1.88 and migrated the crate to
  the 2024 edition.
