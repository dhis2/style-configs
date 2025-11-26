# style-configs

A monorepo for different libaries and configs that are used by the app platform.


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