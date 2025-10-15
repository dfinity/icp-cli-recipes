# Rust Recipe

Build Rust canisters using Cargo with WASM target for the Internet Computer.

## Usage

Example of how to reference this recipe in an `icp.yaml` file:

```yaml
canister:
  name: backend
  recipe:
    type: "@dfinity/rust"
    configuration:
      package: my-canister
      shrink: true
```

## Configuration Parameters

| Parameter | Type | Required | Description | Default |
|-----------|------|----------|-------------|---------|
| package | string | Yes | Name of the Rust package to build | - |
| metadata | array | No | Array of key-value pairs for custom metadata | [] |
| shrink | boolean | No | Enable WASM optimization to reduce file size | false |
| compress | boolean | No | Enable gzip compression of WASM file | false |

## Prerequisites

- Rust toolchain with `wasm32-unknown-unknown` target installed
- `cargo` build system
- `ic-wasm` tool must be installed for metadata injection and optimization

### Installation

```bash
# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Add WASM target
rustup target add wasm32-unknown-unknown

# Install ic-wasm
cargo install ic-wasm
```

## Examples

### Basic Example

```yaml
canister:
  name: hello-rust
  recipe:
    type: "@dfinity/rust"
    configuration:
      package: hello-rust
```

### Advanced Example

```yaml
canister:
  name: dapp-backend
  recipe:
    type: "@dfinity/rust"
    configuration:
      package: dapp-backend
      shrink: true
      compress: true
      metadata:
        - name: "crate:version"
          value: "1.0.0"
        - name: "build:profile"
          value: "release"
```

## Build Process

When this recipe is executed:

1. Runs `cargo build` with the specified package for the `wasm32-unknown-unknown` target in release mode
2. Moves the resulting WASM file from the Cargo target directory to the output location
3. Handles package name conversion (hyphens to underscores for the WASM filename)
4. Injects Cargo version metadata ("cargo:version")
5. Injects template type metadata ("template:type" = "rust")
6. Injects any custom metadata specified in the configuration
7. Optionally optimizes the WASM file if `shrink` is enabled
8. Optionally compresses the WASM file if `compress` is enabled

## Project Structure

A typical Rust canister project structure:

```text
my-project/
├── Cargo.toml           # Package configuration
├── src/
│   ├── lib.rs          # Main canister code
│   └── types.rs        # Type definitions
├── Cargo.lock          # Dependency lock file
└── icp.yaml           # Build configuration
```

### Cargo.toml Example

```toml
[package]
name = "my-canister"
version = "1.0.0"
edition = "2021"

[lib]
crate-type = ["cdylib"]

[dependencies]
ic-cdk = "0.10"
ic-cdk-macros = "0.10"
candid = "0.10"
serde = { version = "1.0", features = ["derive"] }
```

## Common Issues

### Issue 1

**Problem**: `wasm32-unknown-unknown` target not installed
**Solution**: Run `rustup target add wasm32-unknown-unknown` to install the WASM target

### Issue 2

**Problem**: Package not found during build
**Solution**: Verify the package name matches exactly with the name in your `Cargo.toml` file

### Issue 3

**Problem**: Compilation errors
**Solution**: Run `cargo check` locally to identify and fix Rust compilation issues

### Issue 4

**Problem**: WASM file not found after build
**Solution**: Check that your `Cargo.toml` has `crate-type = ["cdylib"]` in the `[lib]` section

## Related Recipes

- [Motoko Recipe](../motoko/README.md) - For building Motoko canisters
- [Pre-built Recipe](../prebuilt/README.md) - For using pre-compiled WASM files
- [Assets Recipe](../assets/README.md) - For frontend assets canister

Use this recipe when developing IC canisters in Rust, which provides performance benefits and access to the rich Rust ecosystem.

## Version History

- v1.0.0 - Initial release with Rust compilation support
