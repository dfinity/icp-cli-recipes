# Assets Recipe

Download and configure the official IC assets canister with asset synchronization capabilities.

## Usage

Example of how to reference this recipe in an `icp.yaml` file:

```yaml
canister:
  name: frontend
  recipe:
    type: assets
    url: https://github.com/dfinity/icp-recipes/releases/download/v1.0.0/recipes/assets/recipe.yml
    configuration:
      version: 0.23.0
      dir: dist
      shrink: true
```

## Configuration Parameters

| Parameter | Type | Required | Description | Default |
|-----------|------|----------|-------------|---------|
| version | string | Yes | SDK version tag to download assets canister from | - |
| dir | string | Yes | Directory containing frontend assets to synchronize | - |
| metadata | array | No | Array of key-value pairs for custom metadata | [] |
| shrink | boolean | No | Enable WASM optimization to reduce file size | false |
| compress | boolean | No | Enable gzip compression of WASM file | false |

## Prerequisites

- `ic-wasm` tool must be installed for metadata injection and optimization
- Frontend assets must be built and available in the specified directory
- Internet connection required to download the assets canister WASM

## Examples

### Basic Example

```yaml
canister:
  name: website
  recipe:
    type: assets
    url: https://github.com/dfinity/icp-recipes/releases/download/v1.0.0/recipes/assets/recipe.yml
    configuration:
      version: 0.23.0
      dir: build
```

### Advanced Example

```yaml
canister:
  name: spa-frontend
  recipe:
    type: assets
    url: https://github.com/dfinity/icp-recipes/releases/download/v1.0.0/recipes/assets/recipe.yml
    configuration:
      version: 0.23.0
      dir: dist
      shrink: true
      compress: true
      metadata:
        - name: "frontend:framework"
          value: "react"
        - name: "frontend:version"
          value: "1.0.0"
```

## Build Process

When this recipe is executed:

1. Downloads the official assets canister WASM from the specified SDK version
2. Injects template type metadata ("template:type" = "assets")
3. Injects any custom metadata specified in the configuration
4. Optionally optimizes the WASM file if `shrink` is enabled
5. Optionally compresses the WASM file if `compress` is enabled
6. Configures asset synchronization for the specified directory

## Asset Synchronization

The assets canister automatically synchronizes files from your specified directory:

- **Static files**: HTML, CSS, JS, images, fonts, etc.
- **SPA support**: Handles client-side routing with fallback to index.html
- **Content encoding**: Automatic gzip compression for supported file types
- **Cache headers**: Optimized caching for static assets

## Common Issues

### Issue 1

**Problem**: Failed to download assets canister WASM
**Solution**: Check your internet connection and verify the SDK version exists at <https://github.com/dfinity/sdk/releases>

### Issue 2

**Problem**: Assets directory not found
**Solution**: Ensure your frontend is built and the specified directory contains the compiled assets

### Issue 3

**Problem**: Asset synchronization not working
**Solution**: Verify your assets directory structure and check that files are accessible and not too large

## Related Recipes

- [Pre-built Recipe](../prebuilt/README.md) - For using custom pre-compiled WASM files
- [Rust Recipe](../rust/README.md) - For building backend Rust canisters
- [Motoko Recipe](../motoko/README.md) - For building backend Motoko canisters

Use this recipe for frontend applications that need to serve static assets and web content on the Internet Computer.

## Version History

- v1.0.0 - Initial release with assets canister support and synchronization
