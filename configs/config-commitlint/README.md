# @dhis2/config-commitlint

Shareable commitlint config for DHIS2 organisation. Extends
`@commitlint/config-conventional`, with the same `header-max-length`/`body-max-line-length`
overrides and release-commit exceptions DHIS2 has historically used.

```sh
pnpm add -D @commitlint/cli @dhis2/config-commitlint
```

```js
// commitlint.config.mjs
import config from '@dhis2/config-commitlint'

export default config
```

Wire it up as a commit-msg hook (e.g. via husky):

```sh
# .husky/commit-msg
npx --no -- commitlint --edit "$1"
```
