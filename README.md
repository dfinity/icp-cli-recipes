# ICP CLI Recipes

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](./LICENSE)

Official build recipe templates for Internet Computer (ICP) canisters. Recipes provide standardized, reusable build configurations using Handlebars templates.

## Available Recipes

| Recipe | Description |
|--------|-------------|
| [**Rust**](recipes/rust/README.md) | Build Rust canisters using Cargo with WASM target |
| [**Motoko**](recipes/motoko/README.md) | Compile Motoko source code using the moc compiler |
| [**Pre-built**](recipes/prebuilt/README.md) | Use pre-compiled WASM files with metadata injection |
| [**Asset Canister**](recipes/asset-canister/README.md) | Deploy the official IC assets canister for frontend apps |

## Quick Start

### Using a Recipe

Reference a recipe in your `icp.yaml` file:

```yaml
canister:
  name: backend
  recipe:
    type: "@dfinity/rust"
    configuration:
      package: my-canister
      shrink: true
```

### Recipe Naming Convention

Recipes follow the `@dfinity/<recipe-name>` naming pattern:
- `@dfinity/rust` - Rust canister recipe
- `@dfinity/motoko` - Motoko canister recipe
- `@dfinity/pre-built` - Pre-built WASM recipe
- `@dfinity/asset-canister` - Asset canister recipe

### Using Specific Versions

To pin to a specific recipe version, append `@<version>` to the recipe type:

```yaml
canister:
  name: backend
  recipe:
    type: "@dfinity/rust@v3.0.0"
    configuration:
      package: my-canister
```

Without a version specified, the latest stable version is used. View available versions in the [releases page](https://github.com/dfinity/icp-cli-recipes/releases).

## Releases

Each recipe is versioned independently. View release history by recipe type:
- [Rust releases](https://github.com/dfinity/icp-cli-recipes/releases?q=rust&expanded=true)
- [Motoko releases](https://github.com/dfinity/icp-cli-recipes/releases?q=motoko&expanded=true)
- [Pre-built releases](https://github.com/dfinity/icp-cli-recipes/releases?q=prebuilt&expanded=true)
- [Asset Canister releases](https://github.com/dfinity/icp-cli-recipes/releases?q=asset-canister&expanded=true)

Releases follow semantic versioning and include auto-generated changelogs.

## Documentation

- [Recipe Authoring Guide](docs/recipe-authoring.md) - Create custom recipes
- [Recipe README Template](docs/recipe-readme-template.md) - Documentation template

## Contributing

Contributions are welcome! Please see the [contribution guide](./.github/CONTRIBUTING.md) for details.

## Support

- Report issues: [GitHub Issues](https://github.com/dfinity/icp-cli-recipes/issues)
- Questions & discussions: [DFINITY Developer Forum](https://forum.dfinity.org/)

## License

This project is licensed under the [Apache-2.0](./LICENSE) license.
