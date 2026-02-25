# Rust Recipe

Build Rust canisters using Cargo with WASM target for the Internet Computer.

## Usage

Example of how to reference this recipe in an `icp.yaml` file:

```yaml
canisters:
  - name: backend
    recipe:
      type: "@dfinity/rust@<version>"
      configuration:
        package: my-canister
        shrink: true
```

> Replace `<version>` with a release version (e.g. `v3.0.0`). See [available versions](https://github.com/dfinity/icp-cli-recipes/releases?q=rust&expanded=true).

## Configuration Parameters

| Parameter | Type    | Required | Description                                  | Default                   |
|-----------|---------|----------|----------------------------------------------|---------------------------|
| package   | string  | Yes      | Name of the Rust package to build            | -                         |
| locked    | boolean | No       | Use exact dependency versions from `Cargo.lock` (passes `--locked` to Cargo) | false                     |
| candid    | string  | No       | Path to a custom Candid interface file. If not provided, the interface is auto-extracted from the WASM using `candid-extractor` | (auto-extracted) |
| metadata  | array   | No       | Array of key-value pairs for custom metadata | []                        |
| shrink    | boolean | No       | Remove unused functions and debug info to reduce file size | false                     |
| compress  | boolean | No       | Gzip compress the WASM file                  | false                     |

## Prerequisites

- Rust toolchain with `wasm32-unknown-unknown` target
- `ic-wasm` (included with icp-cli installation)
- `candid-extractor` (only required if not providing a custom `candid` file)

> **Note:** If you followed the [icp-cli installation guide](https://github.com/dfinity/icp-cli#installation), `ic-wasm` is already installed. You only need to install `candid-extractor` if you want auto-extraction of Candid interfaces.

### Additional Installation

```bash
# Install Rust (if not already installed)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup target add wasm32-unknown-unknown

# Install candid-extractor (only needed if not providing candid file)
cargo install candid-extractor
```

## Examples

### Basic Example

```yaml
canisters:
  - name: hello-rust
    recipe:
      type: "@dfinity/rust@<version>"
      configuration:
        package: hello-rust
```

### Advanced Example

```yaml
canisters:
  - name: dapp-backend
    recipe:
      type: "@dfinity/rust@<version>"
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

1. Runs `cargo build` with the specified package for the `wasm32-unknown-unknown` target in release mode (with `--locked` if enabled)
2. Moves the resulting WASM file from the Cargo target directory to the output location
3. Handles package name conversion (hyphens to underscores for the WASM filename)
4. Injects Cargo version metadata ("cargo:version")
5. Injects template type metadata ("template:type" = "rust")
6. Injects Candid interface: uses the provided `candid` file, or auto-extracts it from the WASM using `candid-extractor`
7. Injects any custom metadata specified in the configuration
8. Optionally removes unused functions if `shrink` is enabled
9. Optionally gzip compresses the WASM file if `compress` is enabled

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
- [Asset Canister Recipe](../asset-canister/README.md) - For frontend assets canister

Use this recipe when developing IC canisters in Rust, which provides performance benefits and access to the rich Rust ecosystem.

## Release History

See the [release history](https://github.com/dfinity/icp-cli-recipes/releases?q=rust&expanded=true) for changelogs, version updates, and breaking changes.
