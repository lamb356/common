# zakura-proofs

`zakura-proofs` is the [Zakura](https://github.com/zakura-core/zakura) fork of
the upstream [`zcash_proofs`](https://crates.io/crates/zcash_proofs) crate from
[zcash/librustzcash](https://github.com/zcash/librustzcash), maintained in
[zakura-core/libraries](https://github.com/zakura-core/libraries). The library
target keeps the upstream name, so `use zcash_proofs::…` paths are unchanged.
Use it as a drop-in replacement by renaming the dependency:

```toml
[dependencies]
zcash_proofs = { package = "zakura-proofs", version = "0.30" }
```

This library contains the Sprout zk-SNARK circuit and the APIs for creating and
verifying Sprout proofs. The Sapling circuits have moved to the `sapling-crypto`
crate (published for Zakura as `zakura-sapling-crypto`); this crate retains
helpers for loading the Sapling proving parameters from disk but no longer
defines those circuits itself.

## License

Licensed under either of

 * Apache License, Version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or
   http://www.apache.org/licenses/LICENSE-2.0)
 * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.

### Contribution

Unless you explicitly state otherwise, any contribution intentionally
submitted for inclusion in the work by you, as defined in the Apache-2.0
license, shall be dual licensed as above, without any additional terms or
conditions.

