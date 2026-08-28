# Changelog

All notable changes to this crate will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this crate adheres to Rust's notion of
[Semantic Versioning](https://semver.org/spec/v2.0.0.html). Entries describe
the crate's public API and observable behavior from a consumer's perspective;
internal implementation details are not tracked here.

## About this fork

`zakura-bls12-381` is Zakura's fork of the upstream `bls12_381` crate. This changelog
begins at the fork point: upstream history up to the fork is documented in the
upstream repository, and the fork's version lineage restarts at `1.0.0` rather
than continuing the upstream `0.8.0` numbering.

- Forked from: `bls12_381 0.8.0`, published from
  [zkcrypto/bls12_381](https://github.com/zkcrypto/bls12_381) at commit
  [`7de7b9d9`](https://github.com/zkcrypto/bls12_381/commit/7de7b9d9c509b9973b35a3241b74bbbea95e700a).
- Imported into this repository in commit `fecb02d3d707444b3b9d8aecc052ddbb48598397`.
- The import also ported the crate from the upstream `ff`/`group` 0.13
  stack to `ff`/`group` 0.14.

## [Unreleased]
