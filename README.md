# style-configs

A monorepo for different libaries and configs that are used by the app platform.

## Dev notes

This repo uses [changesets](https://github.com/changesets/changesets) to manage versioning and changelogs.

To prepare a changeset based on the conventional commits, similar to our previous semantic-release workflow, run: `pnpm changeset-conventional`.

If you open a PR that doesn't contain a changeset, the CI run will fail with this message:

```
Run pnpm changeset status --since=origin/main
🦋  error Some packages have been changed but no changesets were found. Run `changeset add` to resolve this error.
🦋  error If this change doesn't need a release, run `changeset add --empty`.
Error: Process completed with exit code 1.
```

As suggested, if the change doesn't need a release, then you can run `changeset add --empty` to generate an empty changeset.

## Configs

- `configs/eslint-config`: publishes a shareable eslint config to `@dhis2/eslint-config` (and `@dhis2/eslint-config/react`)

- `configs/lslint-config` (ToDo)

- `configs/prettier-config` (ToDo)

- `configs/commitlint-config` (ToDo)

- `configs/stylelint-config` (ToDo)

These should replace `cli-style` eventually (context in [this ticket](https://dhis2.atlassian.net/browse/LIBS-614))

## Other parts to move to this repo (maybe)

Eventually this repo might host other parts of the platform ecosystem. Details in [this ticket](https://dhis2.atlassian.net/browse/LIBS-720):

- `cli`
- `cli-utils-library`
- `cli-helpers-engine`
- `action-semantic-release` (or a shared semantic-release config)
- `cli-utils-codemods`
- `cli-helpers-template`
