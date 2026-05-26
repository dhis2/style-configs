---
'@dhis2/config-eslint': minor
---

Support ESLint 10 by swapping `eslint-plugin-react` for `@eslint-react/eslint-plugin`.

`eslint-plugin-react@7.37.5` (the latest published version) does not support ESLint 10
— its peer dependency is capped at `eslint ^9.7` and several rules call removed
context APIs (`context.getFilename()`, `sourceCode.getAllComments()`). Upstream PRs
for ESLint 10 support are still open.

`@eslint-react/eslint-plugin` is a TypeScript-first rewrite by the jsx-eslint
maintainers and explicitly targets `eslint ^10.3.0`.

**Breaking changes for consumers:**

- The `eslint` peer dependency is now `>= 10.3`.
- Rule names move from `react/*` to `@eslint-react/*`. Consumers with project-local
  overrides on `react/*` rules will need to update them.
- Three PropTypes-specific rules are no longer enforced (the new plugin assumes
  TypeScript and omits them):
    - `react/sort-prop-types`
    - `react/no-unused-prop-types`
    - `react/no-object-type-as-default-prop` (replaced by
      `@eslint-react/no-unstable-default-props`)
