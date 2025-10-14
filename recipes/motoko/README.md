# Motoko Recipe

Compile Motoko source code using the moc compiler to create IC canisters.

## Usage

Example of how to reference this recipe in an `icp.yaml` file:

```yaml
canister:
  name: backend
  recipe:
    type: "@dfinity/motoko"
    configuration:
      entry: src/main.mo
      shrink: true
```

## Configuration Parameters

| Parameter | Type | Required | Description | Default |
|-----------|------|----------|-------------|---------|
| entry | string | Yes | Path to the main Motoko source file | - |
| metadata | array | No | Array of key-value pairs for custom metadata | [] |
| shrink | boolean | No | Enable WASM optimization to reduce file size | false |
| compress | boolean | No | Enable gzip compression of WASM file | false |

## Prerequisites

- `moc` (Motoko compiler) must be installed
- `ic-wasm` tool must be installed for metadata injection and optimization
- Motoko source files must be available in your project

### Installation

To install the Motoko compiler, see: <https://internetcomputer.org/docs/building-apps/getting-started/install>

## Examples

### Basic Example

```yaml
canister:
  name: hello-world
  recipe:
    type: "@dfinity/motoko"
    configuration:
      entry: src/main.mo
```

### Advanced Example

```yaml
canister:
  name: complex-backend
  recipe:
    type: "@dfinity/motoko"
    configuration:
      entry: src/backend.mo
      shrink: true
      compress: true
      metadata:
        - name: "canister:type"
          value: "backend"
        - name: "language:version"
          value: "0.10.0"
```

## Build Process

When this recipe is executed:

1. Checks if the Motoko compiler (`moc`) is installed
2. Compiles the specified Motoko entry file using `moc`
3. Moves the resulting WASM file to the output location
4. Injects compiler version metadata ("moc:version")
5. Injects template type metadata ("template:type" = "motoko")
6. Injects any custom metadata specified in the configuration
7. Optionally optimizes the WASM file if `shrink` is enabled
8. Optionally compresses the WASM file if `compress` is enabled

## Project Structure

A typical Motoko project structure:

```text
my-project/
├── src/
│   ├── main.mo          # Entry point
│   ├── types.mo         # Type definitions
│   └── utils.mo         # Utility functions
├── .vessel/             # Package manager dependencies
└── icp.yaml            # Build configuration
```

## Common Issues

### Issue 1

**Problem**: `moc not found` error
**Solution**: Install the Motoko compiler following the instructions at <https://internetcomputer.org/docs/building-apps/getting-started/install>

### Issue 2

**Problem**: Compilation errors in Motoko code
**Solution**: Check your Motoko syntax and ensure all imports are correctly resolved

### Issue 3

**Problem**: Entry file not found
**Solution**: Verify the entry path is correct relative to your project root and the file exists

### Issue 4

**Problem**: Missing dependencies
**Solution**: Ensure all imported modules are available or install them using vessel package manager

## Related Recipes

- [Rust Recipe](../rust/README.md) - For building Rust canisters
- [Pre-built Recipe](../prebuilt/README.md) - For using pre-compiled WASM files
- [Assets Recipe](../assets/README.md) - For frontend assets canister

Use this recipe when developing IC canisters in Motoko, the native language for the Internet Computer.

## Version History

- v1.0.0 - Initial release with Motoko compilation support
