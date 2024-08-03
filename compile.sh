#!/bin/bash

cargo build -q --release
echo "Release: $(stat --printf="%s" target/release/strip-reproducer)"

cargo rustc -q --release -- -C strip=symbols
echo "strip=symbols: $(stat --printf="%s" target/release/strip-reproducer)"

cargo rustc -q --release -- -C strip=debuginfo
echo "strip=debuginfo: $(stat --printf="%s" target/release/strip-reproducer)"

printf "[profile.release]\nstrip = true\n" >> Cargo.toml
cargo build -q --release
echo "strip = true: $(stat --printf="%s" target/release/strip-reproducer)"
