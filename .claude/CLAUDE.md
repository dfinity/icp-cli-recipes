# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`icp-cli-recipes` contains official build recipe templates for Internet Computer (ICP) canisters. Recipes provide standardized, reusable build configurations using Handlebars templates.

## Repository Structure

```
recipes/
├── rust/           # Rust canister recipe
│   ├── recipe.hbs  # Handlebars template
│   └── README.md   # Documentation
├── motoko/         # Motoko canister recipe
├── prebuilt/       # Pre-built WASM recipe
└── asset-canister/ # Asset canister recipe
```

## Recipe Template Structure

Each recipe is a Handlebars template (`.hbs`) that generates YAML build/sync configuration:

```handlebars
{{! Documentation comments for parameters }}
{{! `param: type` Description }}

build:
  steps:
    - type: script
      commands:
        - command using {{{ param }}}

    {{#if optional_param}}
    - type: script
      commands:
        - conditional command
    {{/if}}
```

## Key Patterns

### Triple-Brace Interpolation

Always use triple-braces `{{{ param }}}` for value interpolation. Handlebars double-braces `{{ param }}` HTML-escape the output (e.g. `&&` becomes `&amp;&amp;`), which breaks shell commands and is never correct in YAML/shell context.

### Required vs Optional Parameters

- **Required parameters**: Used directly as `{{{ param }}}` - will cause strict mode error if missing
- **Optional parameters**: Wrapped in conditionals `{{#if param}}{{{ param }}}{{/if}}`

### Common Configuration Options

Most recipes support these optional parameters:
- `shrink: boolean` - Optimize WASM with ic-wasm shrink
- `compress: boolean` - Gzip compress the WASM
- `metadata: array` - Custom metadata key-value pairs

## Documentation Verification

**IMPORTANT**: When modifying recipes, always verify:

1. **Template matches README**: Every parameter in `recipe.hbs` must be documented in the README
2. **Required vs Optional**: Parameters used directly (not in `{{#if}}`) are required - document accordingly
3. **Config option descriptions**: Each parameter must accurately describe what it does, verified against the actual behavior in `recipe.hbs`. For example, if `shrink` runs `ic-wasm shrink`, the description should reflect what that command does ("Remove unused functions and debug info to reduce file size")
4. **YAML syntax in examples**: Use `canisters: - name:` array syntax, not `canister:`
5. **Recipe type format**: Use `@dfinity/<recipe-name>`, not just `<recipe-name>`
6. **Prerequisites accuracy**: List actual dependencies (mops vs moc, ic-wasm requirements, etc.)
7. **Build process accuracy**: Document what the recipe actually does, step by step

### Cross-Repository Verification

This repository is used by `icp-cli`. When making changes:

1. Check `icp-cli/docs/guides/using-recipes.md` for recipe usage examples
2. Check `icp-cli/examples/` for example projects using recipes
3. Ensure documentation in both repos stays in sync

## Testing Changes

Since recipes are Handlebars templates, test by:

1. Creating a test project with `icp.yaml` using the recipe
2. Running `icp project show` to see the expanded configuration
3. Running `icp build` to verify the build works
