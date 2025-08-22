# ICP Recipes

A comprehensive repository of Internet Computer (IC) canister build recipes using Handlebars templates.

## Overview

This repository serves as the official Dfinity recipe repository for various ICP projects. Recipes are specified as Handlebars templates that generate build configurations for different types of IC canisters.

## Repository Structure

```text
icp-recipes/
├── recipes/                    # Recipe templates organized by type
│   ├── prebuilt/              # Pre-built canister recipes
│   │   ├── recipe.hbs         # Handlebars template
│   │   └── README.md          # Recipe documentation
│   ├── assets/                # Assets canister recipes
│   │   ├── recipe.hbs         # Handlebars template
│   │   └── README.md          # Recipe documentation
│   ├── motoko/                # Motoko canister recipes
│   │   ├── recipe.hbs         # Handlebars template
│   │   └── README.md          # Recipe documentation
│   └── rust/                  # Rust canister recipes
│       ├── recipe.hbs         # Handlebars template
│       └── README.md          # Recipe documentation
├── partials/                  # Shared Handlebars partials
│   ├── wasm-inject-metadata.hbs
│   ├── wasm-shrink.hbs
│   └── wasm-compress.hbs
├── docs/                      # Documentation
│   ├── recipe-authoring.md    # Guide for creating recipes
│   ├── template-reference.md  # Handlebars facilities reference
│   └── contributing.md        # Contribution guidelines
└── .github/                   # CI/CD workflows
    └── workflows/
        └── release.yml        # Automated release workflow
```

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

## Contributing

See [CONTRIBUTING.md](docs/contributing.md) for guidelines on adding new recipes.

## Versioning

This repository follows semantic versioning. Each release publishes recipe artifacts that can be referenced by URL.

## Future Roadmap

- [ ] Recipe validation framework
- [ ] Advanced testing infrastructure
- [ ] Template repository for creating custom recipe libraries
- [ ] Enhanced documentation with interactive examples
- [ ] Community recipe submission process

## License

This project is licensed under the Apache 2.0 License.
