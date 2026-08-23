# syn-serde3

> **Temporary crate.** `syn-serde3` is a short-lived fork of [`syn-serde`] published to fill
> the gap until the upstream crate is updated. It exists because downstream crates built on
> top of `syn-serde` already depend on `syn` 2.x directly, and pulling in a stale upstream
> would introduce a redundant `syn` 2 copy in the dependency graph. Once `syn-serde` releases
> an updated version, this crate will be deprecated — migrate back to `syn-serde` at that
> point.
>
> [`syn-serde`]: https://crates.io/crates/syn-serde

[![license](https://img.shields.io/badge/license-Apache--2.0_OR_MIT-blue?style=flat-square)](#license)
[![msrv](https://img.shields.io/badge/msrv-1.71-blue?style=flat-square&logo=rust)](https://www.rust-lang.org)

<!-- tidy:sync-markdown-to-rustdoc:start:src/lib.rs -->

Library to serialize and deserialize [Syn] syntax trees.

## Usage

Add this to your `Cargo.toml`:

```toml
[dependencies]
syn-serde3 = "0.3"
```

## Examples

```toml
[dependencies]
syn-serde3 = { version = "0.3", features = ["json"] }
syn = { version = "2", features = ["full"] }
```

```rust
use syn_serde3::json;

let syn_file: syn::File = syn::parse_quote! {
    fn main() {
        println!("Hello, world!");
    }
};

println!("{}", json::to_string_pretty(&syn_file));
```

This prints the following JSON:

```json
{
  "items": [
    {
      "fn": {
        "ident": "main",
        "inputs": [],
        "output": null,
        "stmts": [
          {
            "semi": {
              "macro": {
                "path": {
                  "segments": [
                    {
                      "ident": "println"
                    }
                  ]
                },
                "delimiter": "paren",
                "tokens": [
                  {
                    "lit": "\"Hello, world!\""
                  }
                ]
              }
            }
          }
        ]
      }
    }
  ]
}
```

### Rust source file -> JSON representation of the syntax tree

The [`rust2json`] example parse a Rust source file into a `syn_serde3::File`
and print out a JSON representation of the syntax tree.

### JSON file -> Rust syntax tree

The [`json2rust`] example parse a JSON file into a `syn_serde3::File` and
print out a Rust syntax tree.

## Optional features

- **`json`** - Provides functions for JSON <-> Rust serializing and
  deserializing.

## Relationship to Syn

syn-serde3 is a fork of [Syn], and syn-serde3 provides a set of data structures
similar but not identical to [Syn]. All data structures provided by syn-serde3
can be converted to the data structures of [Syn] and [proc-macro2].

The data structures of syn-serde3 is compatible with the data structures of
[Syn] 3.x.

[Syn]: https://github.com/dtolnay/syn
[proc-macro2]: https://github.com/alexcrichton/proc-macro2
[`rust2json`]: https://github.com/yanganto/syn-serde/tree/HEAD/examples/rust2json
[`json2rust`]: https://github.com/yanganto/syn-serde/tree/HEAD/examples/json2rust

<!-- tidy:sync-markdown-to-rustdoc:end -->

## License

Licensed under either of [Apache License, Version 2.0](LICENSE-APACHE) or
[MIT license](LICENSE-MIT) at your option.

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall
be dual licensed as above, without any additional terms or conditions.
