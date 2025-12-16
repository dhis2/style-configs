# style-configs

A monorepo for different libaries and configs that are used by the app platform.

## Configs

These are shareable configs for linting and style formatting. They provide a [modern standard way](https://eslint.org/docs/latest/extend/shareable-configs) of sharing such configs, other than encapsulating them in a library (like we did previously with `cli-style`).

- `configs/eslint-config`: publishes a shareable eslint config to `@dhis2/config-eslint` (and `@dhis2/config-eslint/react`)

- `configs/prettier-config`: publishes a shareable prettier config to `@dhis2/config-prettier`

- `configs/lslint-config` (in progress)

- `configs/commitlint-config` (in progress)

- `configs/stylelint-config` (in progress)

These, once the configs that are in-progress are implemented, should eventually replace `cli-style` (more context in [this ticket](https://dhis2.atlassian.net/browse/LIBS-614)).

The configs before (with cli-style) and after with these configs, should look something like this:

**Before**:

```js
// eslint-disable-next-line @typescript-eslint/no-require-imports
const { config } = require('@dhis2/cli-style')

module.exports = {
    ...require(config.prettier),
}
```

**After**:

```js
import prettierConfig from '@dhis2/config-prettier'

/**
 * @type {import("prettier").Config}
 */
const config = {
    ...prettierConfig,
}

export default config
```

### Upgrading from cli-style

You can run a script to remove existing configs and replace them with the new ones.

```
curl -s https://raw.githubusercontent.com/dhis2/style-configs/refs/heads/main/configs/scripts/install-shared-configs.sh | sh -s -- yarn
```

> [!IMPORTANT]  
> This is a very _crude_ script: it deletes existing configs (for eslint and prettier) and replaces them with the new format using the shared configs. Once you run the script, you **should** test that everything works as expected, and pay special attention if you had custom linting rules as these will need to be re-added manually. In general, this is straight-forward for _prettier_, but might involve some slight changes in _eslint_ as the cli-style used an outdated [config file format](https://eslint.org/blog/2022/08/new-config-system-part-2/).

> [!CAUTION]  
> The script currently does not update the CI workflow. There are too many variations of those to try and automate the process. It does add a `lint` script to `pakcage.json` so it should be easy to run the linting step by doing `pnpm lint` (or `yarn lint`).

You can check [the script](https://github.com/dhis2/style-configs/blob/main/configs/scripts/install-shared-configs.sh) and update it to your specific needs - for example, the script also installs `husky` and `lint-staged` but you might have a different setup in your project.

For an example of a migration, check this PR: [https://github.com/dhis2/route-manager-app/pull/35/files](https://github.com/dhis2/route-manager-app/pull/35/files).

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

### Other parts to move to this repo (maybe)

Eventually this repo might host other parts of the platform ecosystem. Details in [this ticket](https://dhis2.atlassian.net/browse/LIBS-720):

- `cli`
- `cli-utils-library`
- `cli-helpers-engine`
- `action-semantic-release` (or a shared semantic-release config)
- `cli-utils-codemods`
- `cli-helpers-template`
