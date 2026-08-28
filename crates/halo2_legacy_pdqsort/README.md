# zakura-halo2-legacy-pdqsort [![Crates.io](https://img.shields.io/crates/v/zakura-halo2-legacy-pdqsort.svg)](https://crates.io/crates/zakura-halo2-legacy-pdqsort) #

`zakura-halo2-legacy-pdqsort` is the
[Zakura](https://github.com/zakura-core/zakura) fork of the upstream
[`halo2_legacy_pdqsort`](https://crates.io/crates/halo2_legacy_pdqsort) crate
from
[zcash/halo2_legacy_pdqsort](https://github.com/zcash/halo2_legacy_pdqsort),
maintained in
[zakura-core/libraries](https://github.com/zakura-core/libraries). The library
target keeps the upstream name, so `use halo2_legacy_pdqsort::…` paths are
unchanged. Use it as a drop-in replacement by renaming the dependency:

```toml
[dependencies]
halo2_legacy_pdqsort = { package = "zakura-halo2-legacy-pdqsort", version = "0.1" }
```

## [Documentation](https://docs.rs/zakura-halo2-legacy-pdqsort)

## Description

A copy of the `core::slice::sort` module from the Rust 1.56.1 standard
library, modified to behave the same on 32-bit platforms as on 64-bit.
This is intended to work around a determinism bug in the
[`halo2_proofs`](https://github.com/zcash/halo2) crate.

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
