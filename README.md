# `zakura-core/libraries` <img src="https://zakura.com/zakura-flower-v1.svg" alt="Zakura logo" height="32">

This repository contains various Rust libraries used in [Zakura](https://github.com/zakura-core/zakura), many of which are forked from [librustzcash](https://github.com/zcash/librustzcash) and other community crates.

## Transactions and keys

- [`zakura-primitives`](zcash_primitives) (a [fork](https://github.com/zcash/librustzcash/tree/main/zcash_primitives) of `zcash_primitives`)
- [`zakura-keys`](zcash_keys) (a [fork](https://github.com/zcash/librustzcash/tree/main/zcash_keys) of `zcash_keys`)

## Shielded protocols

- [`zakura-orchard`](orchard) (a [fork](https://github.com/zcash/orchard) of `orchard`)
- [`zakura-sapling-crypto`](sapling-crypto) (a [fork](https://github.com/zcash/sapling-crypto) of `sapling-crypto`)
- [`zakura-proofs`](zcash_proofs) (a [fork](https://github.com/zcash/librustzcash/tree/main/zcash_proofs) of `zcash_proofs`)

## The halo2 proving system

- [`zakura-halo2-proofs`](halo2_proofs) (a [fork](https://github.com/zcash/halo2/tree/main/halo2_proofs) of `halo2_proofs`)
- [`zakura-halo2-gadgets`](halo2_gadgets) (a [fork](https://github.com/zcash/halo2/tree/main/halo2_gadgets) of `halo2_gadgets`)
- [`zakura-halo2-poseidon`](halo2_poseidon) (a [fork](https://github.com/zcash/halo2/tree/main/halo2_poseidon) of `halo2_poseidon`)
- [`zakura-halo2-legacy-pdqsort`](halo2_legacy_pdqsort) (a [fork](https://github.com/zcash/halo2_legacy_pdqsort) of `halo2_legacy_pdqsort`)

## Curves, hashes, and signatures

- [`zakura-pasta-curves`](pasta_curves) (a [fork](https://github.com/zcash/pasta_curves) of `pasta_curves`)
- [`zakura-sinsemilla`](sinsemilla) (a [fork](https://github.com/zcash/sinsemilla) of `sinsemilla`)
- [`zakura-reddsa`](reddsa) (a [fork](https://github.com/ZcashFoundation/reddsa) of `reddsa`)
- [`zakura-redjubjub`](redjubjub) (a [fork](https://github.com/ZcashFoundation/redjubjub) of `redjubjub`)

`redjubjub` is a thin wrapper over `reddsa`, so it is forked along with it.

## License

All code in this repository is licensed under either of

- Apache License, Version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or
  [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0))
- MIT license ([LICENSE-MIT](LICENSE-MIT) or
  [opensource.org/licenses/MIT](http://opensource.org/licenses/MIT))

at your option.

### Contribution

Unless you explicitly state otherwise, any contribution intentionally
submitted for inclusion in the work by you, as defined in the Apache-2.0
license, shall be dual licensed as above, without any additional terms or
conditions.
