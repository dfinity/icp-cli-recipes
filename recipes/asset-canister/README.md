# Asset Canister Recipe

Download and configure the official IC assets canister with asset synchronization capabilities.

> [!IMPORTANT]
> Version `v2.2.0` and later of this recipe require **icp-cli v0.2.7 or later**.

## Usage

Example of how to reference this recipe in an `icp.yaml` file:

```yaml
canisters:
  - name: frontend
    recipe:
      type: "@dfinity/asset-canister@<version>"
      configuration:
        version: 0.30.2
        dir: dist
```

> Replace `<version>` with a release version (e.g. `v2.1.0`). See [available versions](https://github.com/dfinity/icp-cli-recipes/releases?q=asset-canister&expanded=true).

## Configuration Parameters

| Parameter | Type | Required | Description | Default |
|-----------|------|----------|-------------|---------|
| version | string | No | SDK version tag to download the asset canister from (e.g., `0.30.2`) | latest |
| dir | string | Yes | Directory containing frontend assets to synchronize to the canister | - |
| build | array | No | Shell commands to build the frontend assets before deployment (e.g., `npm run build`) | [] |
| metadata | array | No | Array of key-value pairs for custom metadata to inject into the WASM | [] |

## Prerequisites

- Frontend assets must either exist in the specified directory or be built using provided `build` commands
- Internet connection required to download the assets canister WASM
- `ic-wasm` (included with icp-cli installation) - only required if using `metadata` option

> **Note:** If you followed the [icp-cli installation guide](https://github.com/dfinity/icp-cli#installation), `ic-wasm` is already installed.

## Examples

### Basic Example

```yaml
canisters:
  - name: website
    recipe:
      type: "@dfinity/asset-canister@<version>"
      configuration:
        dir: build
```

### Advanced Example

```yaml
canisters:
  - name: spa-frontend
    recipe:
      type: "@dfinity/asset-canister@<version>"
      configuration:
        version: 0.30.2
        build:
          - npm install
          - npm run build
        dir: dist
        metadata:
          - name: "frontend:framework"
            value: "react"
          - name: "frontend:version"
            value: "1.0.0"
```

## Build Process

When this recipe is executed:

1. Downloads the official assets canister WASM from the specified SDK version
2. Injects any custom metadata specified in the configuration
3. Configures asset synchronization for the specified directory

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

## Release History

See the [release history](https://github.com/dfinity/icp-cli-recipes/releases?q=asset-canister&expanded=true) for changelogs, version updates, and breaking changes.
