# Instructions:
## Compilation:
```
cargo wasm && docker run --rm -v "$(pwd)":/code \
  --mount type=volume,source="$(basename "$(pwd)")_cache",target=/code/target \
  --mount type=volume,source=registry_cache,target=/usr/local/cargo/registry \
  cosmwasm/rust-optimizer:0.14.0
```
all scripts should be called by executor in zbirenbaum/nft-bridge
