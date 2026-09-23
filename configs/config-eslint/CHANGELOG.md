# @dhis2/config-eslint

## 0.4.0

### Minor Changes

- dc3924e: bump all versions after adding new packages

## 0.3.0

### Patch Changes

- 208c244: fix: rework `@dhis2/config-lslint`'s ruleset to scope to conventional source directories (at
  any nesting depth), with a `__tests__` naming exception and explicit
  spec/test/story/styles/feature/cypress/`.d.ts`/json/yml extension handling for both JS and TS
  projects. Fully ignores generated/framework content (`locales`, `i18n`, `cypress/screenshots`,
  `cypress/downloads`, `cypress/fixtures`, `__mocks__`, `__snapshots__`, `__fixtures__`) instead
  of linting it -- these directories contain auto-generated network-recording snapshots,
  UID-bearing filenames, and API-schema-derived camelCase fixture data in real apps
  (`aggregate-data-entry-app`, `approval-app`, `maintenance-app`) that doesn't fit any naming
  convention. Also fixes the `ignore` list (in both the shared config and this repo's own root
  config) to actually ignore `node_modules`/`build`/`.d2`/etc. at any depth rather than only at
  the scan root -- a bug also present in most of the org's existing hand-written `.ls-lint.yml`
  files.

    Basis: review feedback on dhis2/style-configs#19, plus cross-checking against every
    `.ls-lint.yml` file that currently exists in the `dhis2` org (`cli-style`,
    `aggregate-data-entry-app`, `approval-app`, `metadata-management-app`) and auditing the actual
    `.json`/`.yml`/`.yaml` file paths from 8 more app repos against the resulting ruleset, rather
    than relying on a single example.

    Documents composing the shared config with project-local rules via `ls-lint`'s multi-`--config`
    support (recommended over copying the file, which forks it and stops receiving updates), and
    adds a README to each of the other config packages (`config-eslint`, `config-prettier`,
    `config-stylelint`, `config-commitlint`) for parity.

- 208c244: chore: publish to alpha

## 0.3.0-alpha.0

### Patch Changes

- 0f19dac: chore: publish to alpha

## 0.2.2

### Patch Changes

- c7756ff: chore: remove build steps
- c7756ff: chore: setup linting for the monorepo

## 0.2.1

## 0.2.0

## 0.1.1

### Patch Changes

- 073164c: fix(eslint): fix precedence for TS no-unused-vars

## 0.1.0

### Minor Changes

- dae45cf: fix: apply unused-vars correctly

## 0.0.4

### Patch Changes

- 8e79efd: fix: move linting packages to dependencies not devDependencies

## 0.0.3

### Patch Changes

- db6c952: chore: update GH_TOKEN

## 0.0.2

### Patch Changes

- 705f331: setup package to be published to npm

## 1.0.1

### Patch Changes

- 958cfd0: chore: test changesets workflow
