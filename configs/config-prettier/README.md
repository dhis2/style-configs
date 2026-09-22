# @dhis2/config-prettier

Shareable Prettier config for DHIS2 organisation.

```sh
pnpm add -D prettier @dhis2/config-prettier
```

```js
// .prettierrc.mjs
import prettierConfig from '@dhis2/config-prettier'

/**
 * @type {import("prettier").Config}
 */
const config = {
    ...prettierConfig,
}

export default config
```
