# Changelog

All notable changes to this crate will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this crate adheres to Rust's notion of
[Semantic Versioning](https://semver.org/spec/v2.0.0.html). Entries describe
the crate's public API and observable behavior from a consumer's perspective;
internal implementation details are not tracked here.

## About this fork

`zakura-pairing` is Zakura's fork of the upstream `pairing` crate. This changelog
begins at the fork point: upstream history up to the fork is documented in the
upstream repository, and the fork's version lineage restarts at `1.0.0` rather
than continuing the upstream `0.23.0` numbering.

- Forked from: `pairing 0.23.0`, published from
  [zkcrypto/pairing](https://github.com/zkcrypto/pairing) at commit
  [`11eff5b3`](https://github.com/zkcrypto/pairing/commit/11eff5b3680a08b09c61cbe75eaa803a1e85d80b).
- Imported into this repository in commit `295ad3fb0f7a8dd5c9ac781dd9b5a05a5eac8473`.
- The import also ported the crate from the upstream `ff`/`group` 0.13
  stack to `ff`/`group` 0.14.

## [Unreleased]
