# zakura-primitives

`zakura-primitives` is the [Zakura](https://github.com/zakura-core/zakura) fork
of the upstream
[`zcash_primitives`](https://crates.io/crates/zcash_primitives) crate from
[zcash/librustzcash](https://github.com/zcash/librustzcash), maintained in
[zakura-core/libraries](https://github.com/zakura-core/libraries). The library
target keeps the upstream name, so `use zcash_primitives::…` paths are
unchanged. Use it as a drop-in replacement by renaming the dependency:

```toml
[dependencies]
zcash_primitives = { package = "zakura-primitives", version = "0.30" }
```

This library contains Rust implementations of the Zcash primitives.

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

