# @dhis2/config-eslint

Shareable ESLint flat config for DHIS2 organisation.

```sh
pnpm add -D eslint @eslint/compat @dhis2/config-eslint
```

```js
// eslint.config.mjs
import config from '@dhis2/config-eslint'
import { defineConfig } from 'eslint/config'
import { includeIgnoreFile } from '@eslint/compat'
import { fileURLToPath } from 'node:url'

const gitignorePath = fileURLToPath(new URL('.gitignore', import.meta.url))

export default defineConfig([
    includeIgnoreFile(gitignorePath, 'Imported .gitignore patterns'),
    {
        extends: [config],
    },
])
```

## React

A React-aware variant (adds `eslint-plugin-react`/`eslint-plugin-react-hooks`) is published as
`@dhis2/config-eslint/react` — use it in place of the default export above if your project uses
React:

```js
import config from '@dhis2/config-eslint/react'
```
