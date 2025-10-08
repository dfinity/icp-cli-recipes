# ICP Recipes

A comprehensive repository of Internet Computer (IC) canister build recipes using Handlebars templates.

## Overview

This repository serves as the official Dfinity recipe repository for various ICP projects. Recipes are specified as Handlebars templates that generate build configurations for different types of IC canisters.

## Using Recipes

Recipes are consumed by referencing them in your `icp.yaml` file:

```yaml
canister:
  name: my-canister
  recipe:
    type: prebuilt
    url: https://github.com/dfinity/icp-recipes/releases/download/v1.0.0/recipes/prebuilt/recipe.yml
    configuration:
      path: ../dist/my-canister.wasm
      sha256: 17a05e36278cd04c7ae6d3d3226c136267b9df7525a0657521405e22ec96be7a
```

## Recipe Types

- **prebuilt**: For using pre-compiled WASM files
- **assets**: For the official IC assets canister with asset synchronization
- **motoko**: For compiling Motoko source code
- **rust**: For building Rust canisters with Cargo

## Recipe Authoring Guide

See [Recipe Authoring Guide](docs/recipe-authoring.md) for guidelines on creating new recipes.

## Versioning

This repository follows semantic versioning. Each release publishes recipe artifacts that can be referenced by URL.

## Future Roadmap

- [ ] Recipe validation framework
- [ ] Advanced testing infrastructure
- [ ] Template repository for creating custom recipe libraries
- [ ] Enhanced documentation with interactive examples
- [ ] Community recipe submission process

## Contributing

Contributions are welcome! Please see the [contribution guide](./.github/CONTRIBUTING.md) for more information.

## License

This project is licensed under the [Apache-2.0](./LICENSE) license.
