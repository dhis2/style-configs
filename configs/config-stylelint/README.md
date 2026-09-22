# @dhis2/config-stylelint

Shareable Stylelint config for DHIS2 organisation. Enforces logical CSS properties (via
`stylelint-use-logical`), with a `postcss-styled-jsx` override for CSS embedded in `<style
jsx>` blocks.

```sh
pnpm add -D stylelint @dhis2/config-stylelint
```

```js
// stylelint.config.mjs
import config from '@dhis2/config-stylelint'

/**
 * @type {import("stylelint").Config}
 */
const stylelintConfig = {
    ...config,
}

export default stylelintConfig
```

```sh
stylelint '**/*.{css,js,jsx,ts,tsx}'
```
