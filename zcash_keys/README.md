# zakura-keys

`zakura-keys` is the [Zakura](https://github.com/zakura-core/zakura) fork of
the upstream [`zcash_keys`](https://crates.io/crates/zcash_keys) crate from
[zcash/librustzcash](https://github.com/zcash/librustzcash), maintained in
[zakura-core/libraries](https://github.com/zakura-core/libraries). The library
target keeps the upstream name, so `use zcash_keys::…` paths are unchanged. Use
it as a drop-in replacement by renaming the dependency:

```toml
[dependencies]
zcash_keys = { package = "zakura-keys", version = "0.16" }
```

This library contains Rust structs and traits for Zcash key and address parsing
and encoding.

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

