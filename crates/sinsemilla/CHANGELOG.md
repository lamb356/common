# Changelog

All notable changes to this crate will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this crate adheres to Rust's notion of
[Semantic Versioning](https://semver.org/spec/v2.0.0.html). Entries describe
the crate's public API and observable behavior from a consumer's perspective;
internal implementation details are not tracked here.

## About this fork

`zakura-sinsemilla` is Zakura's fork of the upstream `sinsemilla` crate. This changelog
begins at the fork point: upstream history up to the fork is documented in the
upstream repository, and the fork's version lineage restarts at `1.0.0` rather
than continuing the upstream `0.1.0` numbering.

- Forked from: `sinsemilla 0.1.0`, published from
  [zcash/sinsemilla](https://github.com/zcash/sinsemilla) at commit
  [`206f7a96`](https://github.com/zcash/sinsemilla/commit/206f7a960c55222a138a85447f1ddc666822cac0).
- Imported into this repository in commit `a57d014096a67071a2c6522a160c7e0dfbeff0f4`.

## [Unreleased]

## [1.0.0] - 2026-08-28

### Added

- Added the `weighted` module: `weighted::UncheckedFixedLengthHashDomain<N>`
  precomputes a per-`HashDomain` table (its heap size is reported by
  `table_bytes`) and hashes messages of exactly `N` ten-bit words — `hash_words`
  and `hash_words_to_point` take pre-decoded words, while `hash` and
  `hash_to_point` take bit iterators — panicking on a wrong word count or an
  out-of-range word. Unlike `HashDomain`, it returns `pallas` values directly
  rather than `CtOption`, omitting the incomplete-addition failure cases; the
  module documentation gives the discrete-logarithm argument for why those cases
  are computationally infeasible to reach for independently generated domain
  constants.
- Added batch evaluation to `weighted::UncheckedFixedLengthHashDomain`:
  `hash_words_batch` hashes a slice of same-length messages together, and
  `hash_words_batch_with_workspace` does the same while reusing temporary
  allocations held in the new `weighted::BatchHashWorkspace` type.

### Changed

- Renamed the package from `sinsemilla` to `zakura-sinsemilla`; the library
  target keeps its upstream name, so existing `use` paths compile unchanged.
- Replaced the upstream `pasta_curves` dependency with the Zakura fork
  (`zakura-pasta-curves` 1.0.0), whose types appear in this crate's API.
- Updated `group` from 0.13 to 0.14; the `pallas` point and field types this
  crate exposes now implement the `ff`/`group` 0.14 traits.
- Sped up `HashDomain::hash_to_point` and `HashDomain::hash`; results and
  exceptional-case failure behavior are unchanged.
- Raised the minimum supported Rust version to 1.88 and migrated the crate to
  the 2024 edition.
