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

# Optional sync section for recipes that need asset synchronization
sync:
  steps:
    - type: [sync-step-type]
      [sync-configuration]
```

## Available Template Facilities

### Handlebars Helpers

#### Built-in Helpers

icp-cli support the default helpers, see: [handlebars documentation](https://handlebarsjs.com/guide/builtin-helpers.html)

In addition, it provides the following helpers:

- `{{replace "search" "replace" string}}` - String replacement

More helpers might be added in the future.

## Creating a New Recipe

### 1. Directory Structure

```
recipes/[recipe-name]/
├── recipe.hbs          # Handlebars template
└── README.md           # Documentation following template
```

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

## Submission Process

1. **Create recipe directory** with template and README
2. **Test thoroughly** with real projects
3. **Follow documentation standards** using the README template
4. **Submit pull request** with clear description
5. **Address review feedback** promptly

See [CONTRIBUTING.md](contributing.md) for detailed submission guidelines.
