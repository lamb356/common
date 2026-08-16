# zakura-libraries

This workspace contains libraries used in [zakura](https://github.com/zakura-core/zakura), originally forked from the ZCash proving stack and librustzcash, for maintenance and further development by the Zakura project. Zakura never pull in any of the originally-forked dependencies.

Each crate is named after its zakura-branded crates.io reservation (see the `reserved` repository for the full mapping), listed below next to the upstream name. Directory names and library target names keep the upstream names, so `use` paths are unchanged.

## From librustzcash

The [librustzcash](https://github.com/zcash/librustzcash) members consumed by Zakura that depend on the proving stack:

- `zcash_primitives` (`zakura-primitives`) — transaction structure, builders, txids, and sighashes
- `zcash_keys` (`zakura-keys`) — key derivation and address encoding
- `zcash_proofs` (`zakura-proofs`) — the Sapling Groth16 prover and proving-parameter handling

## Core Crypto Libraries

- `pasta_curves` (`zakura-pasta-curves`) — the Pallas/Vesta curve cycle underlying Orchard and halo2
- `sinsemilla` (`zakura-sinsemilla`) — the Sinsemilla hash function (Pallas-based)
- `reddsa` (`zakura-reddsa`) — RedDSA signatures: RedPallas (Orchard) and RedJubjub (Sapling)

## The Orchard Proving Stack

- `halo2_proofs` (`zakura-halo2-proofs`) — the halo2 proving system
- `halo2_gadgets` (`zakura-halo2-gadgets`) — circuit gadgets built on halo2_proofs
- `halo2_poseidon` (`zakura-halo2-poseidon`) — the Poseidon hash gadget
- `halo2_legacy_pdqsort` (`zakura-halo2-legacy-pdqsort`) — pinned sort behavior for the legacy V1 floor planner
- `orchard` (`zakura-orchard`) — the Orchard shielded protocol and circuit

## The Sapling Proving Stack

Due to Sapling's redjubjub crate being a wrapper around reddsa, these crates also had to be forked:

- `redjubjub` (`zakura-redjubjub`) — RedJubjub signature wrapper over reddsa
- `sapling-crypto` (`zakura-sapling-crypto`) — the Sapling shielded protocol

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
