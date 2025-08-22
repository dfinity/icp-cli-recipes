# Recipe README Template

This document defines the standardized structure for recipe README files. Each recipe directory should contain a `README.md` file following this template.

## Template Structure

```markdown
# [Recipe Name] Recipe

Brief description of what this recipe does and when to use it.

## Usage

Example of how to reference this recipe in an `icp.yaml` file:

```yaml
canister:
  name: my-canister
  recipe:
    type: [recipe-type]
    url: https://github.com/dfinity/icp-recipes/releases/download/v1.0.0/recipes/[recipe-name]/recipe.yml
    configuration:
      # Recipe-specific configuration parameters
```

## Configuration Parameters

| Parameter | Type | Required | Description | Default |
|-----------|------|----------|-------------|---------|
| param1 | string | Yes | Description of parameter | - |
| param2 | boolean | No | Description of parameter | false |

## Prerequisites

- List any required tools, dependencies, or setup
- Include installation links where helpful

## Examples

### Basic Example

[Provide a minimal working example]

### Advanced Example

[Provide a more complex example showcasing additional features]

## Build Process

Explain what happens when this recipe is executed:

1. Step 1 description
2. Step 2 description
3. Final output description

## Common Issues

### Issue 1

**Problem**: Description of common problem
**Solution**: How to resolve it

### Issue 2

**Problem**: Description of another common problem
**Solution**: How to resolve it

## Related Recipes

- Link to related or similar recipes
- Explain when to use this recipe vs alternatives

## Version History

- v1.0.0 - Initial release
- v1.1.0 - Added feature X

## Guidelines

### Writing Style

- Use clear, concise language
- Target both beginners and experienced developers
- Include practical examples
- Explain the "why" not just the "how"

### Code Examples

- All examples should be complete and runnable
- Use realistic parameter values
- Include expected outputs where helpful

### Documentation Standards

- All configuration parameters must be documented
- Include prerequisites and dependencies
- Provide troubleshooting for common issues
- Link to related documentation when relevant

## Example Implementation

See the individual recipe directories for examples of this template in action:

- `recipes/prebuilt/README.md`
- `recipes/assets/README.md`
- `recipes/motoko/README.md`
- `recipes/rust/README.md`
