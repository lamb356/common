# Changelog

All notable changes to this crate will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this crate adheres to Rust's notion of
[Semantic Versioning](https://semver.org/spec/v2.0.0.html). Entries describe
the crate's public API and observable behavior from a consumer's perspective;
internal implementation details are not tracked here.

## About this fork

`zakura-bellman` is Zakura's fork of the upstream `bellman` crate. This changelog
begins at the fork point: upstream history up to the fork is documented in the
upstream repository, and the fork's version lineage restarts at `1.0.0` rather
than continuing the upstream `0.14.0` numbering.

- Forked from: `bellman 0.14.0`, published from
  [zkcrypto/bellman](https://github.com/zkcrypto/bellman) at commit
  [`e1377750`](https://github.com/zkcrypto/bellman/commit/e137775023a647716793a362ace008e058679b2a).
- Imported into this repository in commit `7f4d4d0d9ad4ef7af62196403570bdf3ca3718e8`.
- The import also ported the crate from the upstream `ff`/`group` 0.13
  stack to `ff`/`group` 0.14.

## [Unreleased]
