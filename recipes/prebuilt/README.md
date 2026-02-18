# Pre-built Recipe

Use pre-compiled WASM files with optional optimization and metadata injection.

## Usage

Example of how to reference this recipe in an `icp.yaml` file:

```yaml
canisters:
  - name: my-canister
    recipe:
      type: "@dfinity/prebuilt@<version>"
      configuration:
        path: dist/canister.wasm
        sha256: 17a05e36278cd04c7ae6d3d3226c136267b9df7525a0657521405e22ec96be7a
        shrink: true
        compress: true
        metadata:
          - name: "custom:version"
            value: "1.0.0"
```

> Replace `<version>` with a release version (e.g. `v2.0.0`). See [available versions](https://github.com/dfinity/icp-cli-recipes/releases?q=prebuilt&expanded=true).

## Configuration Parameters

| Parameter | Type | Required | Description | Default |
|-----------|------|----------|-------------|---------|
| path | string | Yes | Local path to the pre-built WASM file | - |
| sha256 | string | No | SHA256 hash for integrity verification. Generate with `sha256sum <file>.wasm` | - |
| shrink | boolean | No | Remove unused functions and debug info to reduce file size | false |
| compress | boolean | No | Gzip compress the WASM file | false |
| metadata | array | No | Array of key-value pairs for custom metadata to inject into the WASM | [] |

## Prerequisites

- Pre-compiled WASM file must exist at the specified path
- `ic-wasm` (included with icp-cli installation) - only required if using `metadata` or `shrink` options

> **Note:** If you followed the [icp-cli installation guide](https://github.com/dfinity/icp-cli#installation), `ic-wasm` is already installed.

> **Note:** Providing a SHA256 hash is optional but recommended for integrity verification.

## Examples

### Basic Example

```yaml
canisters:
  - name: simple-canister
    recipe:
      type: "@dfinity/prebuilt@<version>"
      configuration:
        path: target/wasm32-unknown-unknown/release/my_canister.wasm
        sha256: abc123def456...
```

### Advanced Example

```yaml
canisters:
  - name: optimized-canister
    recipe:
      type: "@dfinity/prebuilt@<version>"
      configuration:
        path: dist/production-canister.wasm
        sha256: xyz789abc123...
        shrink: true
        compress: true
        metadata:
          - name: "build:version"
            value: "2.1.0"
          - name: "build:environment"
            value: "production"
          - name: "build:timestamp"
            value: "2024-01-01T00:00:00Z"
```

## Build Process

When this recipe is executed:

1. Copies the pre-built WASM file to the output location
2. Verifies file integrity using the provided SHA256 hash (if specified)
3. Injects any custom metadata specified in the configuration (if specified)
4. Optionally optimizes the WASM file if `shrink` is enabled
5. Optionally compresses the WASM file if `compress` is enabled

## Common Issues

### Issue 1

**Problem**: SHA256 hash mismatch error
**Solution**: Verify the WASM file hasn't been modified and regenerate the hash using `sha256sum your-file.wasm`

### Issue 2

**Problem**: `ic-wasm` command not found
**Solution**: Install the IC WASM tool following the instructions at <https://github.com/dfinity/ic-wasm>

### Issue 3

**Problem**: WASM file not found at specified path
**Solution**: Verify the path is correct relative to your project root and the file exists

## Related Recipes

- [Rust Recipe](../rust/README.md) - For building Rust canisters from source
- [Motoko Recipe](../motoko/README.md) - For building Motoko canisters from source
- [Asset Canister Recipe](../asset-canister/README.md) - For the official IC assets canister

Use this recipe when you have a pre-compiled WASM file and want to add metadata or optimize it without rebuilding from source.

## Release History

See the [release history](https://github.com/dfinity/icp-cli-recipes/releases?q=prebuilt&expanded=true) for changelogs, version updates, and breaking changes.
