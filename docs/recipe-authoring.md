# Recipe Authoring Guide

This guide explains how to create new recipe templates for the ICP Recipes repository.

## Overview

Recipes are Handlebars templates that generate YAML build configurations for IC canisters. They provide a standardized way to build different types of canisters while allowing customization through template variables.

## Template Structure

All recipe templates follow this basic structure:

```yaml
build:
  steps:
    - type: [build-step-type]
      [step-specific-configuration]

    {{> wasm-inject-metadata name="template:type" value="[recipe-type]" }}

    {{#if metadata }}
    {{#each metadata }}
    {{> wasm-inject-metadata name=name value=value }}
    {{/each}}
    {{/if}}

    {{#if shrink }}
    {{> wasm-shrink }}
    {{/if}}

    {{#if compress }}
    {{> wasm-compress }}
    {{/if}}

# Optional sync section for recipes that need asset synchronization
sync:
  steps:
    - type: [sync-step-type]
      [sync-configuration]
```

## Available Template Facilities

### Handlebars Helpers

#### Built-in Helpers

- `{{#if condition}}` - Conditional rendering
- `{{#each array}}` - Loop over arrays
- `{{#unless condition}}` - Inverse conditional
- `{{replace "search" "replace" string}}` - String replacement

#### Custom Helpers

- `{{sha256 file}}` - Generate SHA256 hash of a file
- `{{fileExists path}}` - Check if file exists

### Shared Partials

#### `{{> wasm-inject-metadata}}`

Injects metadata into a WASM file.

**Parameters:**

- `name` (required): Metadata key name
- `value` (required): Metadata value

**Example:**

```handlebars
{{> wasm-inject-metadata name="template:type" value="rust" }}
{{> wasm-inject-metadata name="cargo:version" value="1.70.0" }}
```

#### `{{> wasm-shrink}}`

Optimizes WASM file size by removing unnecessary sections.

**Parameters:** None

**Example:**

```handlebars
{{#if shrink }}
{{> wasm-shrink }}
{{/if}}
```

#### `{{> wasm-compress}}`

Compresses the WASM file using gzip compression.

**Parameters:** None

**Example:**

```handlebars
{{#if compress }}
{{> wasm-compress }}
{{/if}}
```

## Build Step Types

### `pre-built`

Uses a pre-compiled WASM file.

**Configuration:**

- `path`: Local path to WASM file
- `url`: URL to download WASM file
- `sha256`: Expected SHA256 hash

### `script`

Executes shell commands to build the canister.

**Configuration:**

- `commands`: Array of shell commands to execute

### Environment Variables

The following environment variables are available during build:

- `ICP_WASM_OUTPUT_PATH`: Path where the final WASM should be written
- `ICP_SOURCE_DIR`: Directory containing source code
- `ICP_BUILD_DIR`: Temporary build directory

## Creating a New Recipe

### 1. Directory Structure

```
recipes/[recipe-name]/
├── recipe.hbs          # Handlebars template
└── README.md           # Documentation following template
```

### 2. Template Development

Start with this basic template:

```handlebars
build:
  steps:
    # Add your build steps here
    - type: script
      commands:
        - echo "Building {{canister_name}}"

    {{> wasm-inject-metadata name="template:type" value="{{recipe_type}}" }}

    {{#if metadata }}
    {{#each metadata }}
    {{> wasm-inject-metadata name=name value=value }}
    {{/each}}
    {{/if}}

    {{#if shrink }}
    {{> wasm-shrink }}
    {{/if}}

    {{#if compress }}
    {{> wasm-compress }}
    {{/if}}
```

### 3. Configuration Parameters

Define what parameters your recipe accepts:

```handlebars
# For a Rust recipe
- cargo build --package {{ package }} --target wasm32-unknown-unknown --release
- mv target/wasm32-unknown-unknown/release/{{ replace "-" "_" package }}.wasm "$ICP_WASM_OUTPUT_PATH"
```

### 4. Testing Your Recipe

Before submitting, test your recipe with:

1. **Manual testing**: Use the template with sample parameters
2. **Integration testing**: Build an actual canister using the recipe
3. **Documentation review**: Ensure README follows the template

## Best Practices

### Template Design

- **Keep it simple**: Start with minimal required functionality
- **Make it configurable**: Use template variables for customization
- **Handle edge cases**: Use conditionals for optional features
- **Follow conventions**: Use established patterns from existing recipes

### Parameter Naming

- Use `snake_case` for parameter names
- Choose descriptive, unambiguous names
- Group related parameters logically
- Provide sensible defaults when possible

### Error Handling

- Validate required tools are available
- Provide clear error messages
- Fail fast if prerequisites aren't met
- Include troubleshooting in documentation

### Documentation

- Document all parameters clearly
- Provide working examples
- Explain prerequisites and setup
- Include common troubleshooting scenarios

## Recipe Examples

### Simple Script Recipe

```handlebars
build:
  steps:
    - type: script
      commands:
        - npm install
        - npm run build
        - cp dist/main.wasm "$ICP_WASM_OUTPUT_PATH"

    {{> wasm-inject-metadata name="template:type" value="npm" }}
```

### Conditional Features Recipe

```handlebars
build:
  steps:
    - type: script
      commands:
        {{#if debug}}
        - cargo build --target wasm32-unknown-unknown
        {{else}}
        - cargo build --target wasm32-unknown-unknown --release
        {{/if}}

    {{#if optimize}}
    {{> wasm-shrink }}
    {{/if}}
```

## Submission Process

1. **Create recipe directory** with template and README
2. **Test thoroughly** with real projects
3. **Follow documentation standards** using the README template
4. **Submit pull request** with clear description
5. **Address review feedback** promptly

See [CONTRIBUTING.md](contributing.md) for detailed submission guidelines.
