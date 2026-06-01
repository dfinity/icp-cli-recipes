# Motoko Recipe

Compile Motoko source code using `mops build` to create IC canisters.

## Usage

Example of how to reference this recipe in an `icp.yaml` file:

```yaml
canisters:
  - name: backend
    recipe:
      type: "@dfinity/motoko@<version>"
      configuration:
        shrink: true
```

> Replace `<version>` with a release version (e.g. `v5.0.0`). See [available versions](https://github.com/dfinity/icp-cli-recipes/releases?q=motoko&expanded=true).

The canister must also be defined in `mops.toml`. The key in the `[canisters]` section must match the canister name in `icp.yaml`:

```toml
[toolchain]
moc = "1.8.2"

[canisters]
backend = "src/main.mo"
```

Compiler flags, per-canister args, and the Candid file are all configured in `mops.toml`. See the [mops documentation](https://mops.one/docs) for the full `[canisters]` schema.

## Configuration Parameters

| Parameter | Type    | Required | Description                                  | Default |
|-----------|---------|----------|----------------------------------------------|---------|
| metadata  | array   | No       | Array of key-value pairs for custom metadata | []      |
| shrink    | boolean | No       | Remove unused functions and debug info to reduce file size | false   |
| compress  | boolean | No       | Gzip compress the WASM file                  | false   |

## Prerequisites

- `mops` (Motoko package manager) — manages the toolchain, dependencies, and canister build
- `ic-wasm` (included with icp-cli installation)

> **Note:** If you followed the [icp-cli installation guide](https://github.com/dfinity/icp-cli#installation), both `mops` and `ic-wasm` are already installed.

### Additional Installation

If mops is not installed, see: <https://mops.one/docs/install>

## Examples

### Basic Example

```yaml
# icp.yaml
canisters:
  - name: hello-world
    recipe:
      type: "@dfinity/motoko@<version>"
```

```toml
# mops.toml
[toolchain]
moc = "1.8.2"

[canisters]
hello-world = "src/main.mo"
```

### Advanced Example

```yaml
# icp.yaml
canisters:
  - name: backend
    recipe:
      type: "@dfinity/motoko@<version>"
      configuration:
        shrink: true
        compress: true
        metadata:
          - name: "canister:type"
            value: "backend"
```

```toml
# mops.toml
[toolchain]
moc = "1.8.2"

[dependencies]
core = "2.5.0"

[moc]
args = ["--default-persistent-actors"]

[canisters.backend]
main = "src/main.mo"
candid = "backend.did"
```

## Build Process

When this recipe is executed:

1. Checks if `mops` and `ic-wasm` are installed
2. Runs `mops build <name>` which compiles the canister using the toolchain, dependencies, and compiler flags defined in `mops.toml`
3. Copies the built WASM to the icp-cli output path
4. Injects compiler version metadata (`moc:version`)
5. Injects template type metadata (`template:type` = `motoko`)
6. Injects any custom metadata specified in the configuration
7. Optionally removes unused functions if `shrink` is enabled
8. Optionally gzip compresses the WASM file if `compress` is enabled

## Project Structure

A typical Motoko project structure:

```text
my-project/
├── src/
│   ├── main.mo          # Entry point
│   ├── types.mo         # Type definitions
│   └── utils.mo         # Utility functions
├── mops.toml            # Toolchain, dependencies, canister config
└── icp.yaml             # Build configuration
```

## Migrating from v4

The `main`, `candid`, and `args` recipe parameters have been removed. Move them to `mops.toml`:

| Before (`icp.yaml`)         | After (`mops.toml`)                        |
|-----------------------------|--------------------------------------------|
| `main: src/main.mo`         | `[canisters.backend] main = "src/main.mo"` |
| `candid: backend.did`       | `[canisters.backend] candid = "backend.did"` |
| `args: --incremental-gc`    | `[canisters.backend] args = ["--incremental-gc"]` |

The canister name in `icp.yaml` is used automatically — no additional recipe configuration is needed.

## Common Issues

### "No Motoko canisters found in mops.toml configuration"

The `[canisters]` section is missing from `mops.toml`, or the canister name does not match the `name` parameter in `icp.yaml`. Ensure the key in `[canisters]` exactly matches the `name` value in the recipe configuration.

### "moc not found" error

Install the Motoko compiler via mops: run `mops install` in your project directory. The toolchain version is set in `mops.toml` under `[toolchain]`.

### Compilation errors

Check your Motoko syntax and ensure all imports resolve. Run `mops check` for detailed diagnostics.

## Related Recipes

- [Rust Recipe](../rust/README.md) - For building Rust canisters
- [Pre-built Recipe](../prebuilt/README.md) - For using pre-compiled WASM files
- [Asset Canister Recipe](../asset-canister/README.md) - For frontend assets canister

## Release History

See the [release history](https://github.com/dfinity/icp-cli-recipes/releases?q=motoko&expanded=true) for changelogs, version updates, and breaking changes.
