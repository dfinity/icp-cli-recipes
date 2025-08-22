# Pre-built Recipe

Use pre-compiled WASM files with optional optimization and metadata injection.

## Usage

Example of how to reference this recipe in an `icp.yaml` file:

```yaml
canister:
  name: my-canister
  recipe:
    type: prebuilt
    url: https://github.com/dfinity/icp-recipes/releases/download/v1.0.0/recipes/prebuilt/recipe.yml
    configuration:
      path: dist/canister.wasm
      sha256: 17a05e36278cd04c7ae6d3d3226c136267b9df7525a0657521405e22ec96be7a
      shrink: true
      compress: false
      metadata:
        - name: "custom:version"
          value: "1.0.0"
```

## Configuration Parameters

| Parameter | Type | Required | Description | Default |
|-----------|------|----------|-------------|---------|
| path | string | Yes | Local path to the pre-built WASM file | - |
| sha256 | string | Yes | SHA256 hash for integrity verification | - |
| metadata | array | No | Array of key-value pairs for custom metadata | [] |
| shrink | boolean | No | Enable WASM optimization to reduce file size | false |
| compress | boolean | No | Enable gzip compression of WASM file | false |

## Prerequisites

- `ic-wasm` tool must be installed for metadata injection and optimization
- Pre-compiled WASM file must exist at the specified path
- SHA256 hash must be provided for integrity verification

## Examples

### Basic Example

```yaml
canister:
  name: simple-canister
  recipe:
    type: prebuilt
    url: https://github.com/dfinity/icp-recipes/releases/download/v1.0.0/recipes/prebuilt/recipe.yml
    configuration:
      path: target/wasm32-unknown-unknown/release/my_canister.wasm
      sha256: abc123def456...
```

### Advanced Example

```yaml
canister:
  name: optimized-canister
  recipe:
    type: prebuilt
    url: https://github.com/dfinity/icp-recipes/releases/download/v1.0.0/recipes/prebuilt/recipe.yml
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
2. Verifies file integrity using the provided SHA256 hash
3. Injects template type metadata ("template:type" = "pre-built")
4. Injects any custom metadata specified in the configuration
5. Optionally optimizes the WASM file if `shrink` is enabled
6. Optionally compresses the WASM file if `compress` is enabled

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
- [Assets Recipe](../assets/README.md) - For the official IC assets canister

Use this recipe when you have a pre-compiled WASM file and want to add metadata or optimize it without rebuilding from source.

## Version History

- v1.0.0 - Initial release with basic pre-built WASM support
