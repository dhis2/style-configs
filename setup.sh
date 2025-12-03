#!/usr/bin/env bash
pnpm add -D eslint
pnpm add -D @eslint/compat
pnpm add -D prettier
pnpm add -D husky
pnpm add -D lint-staged
pnpm add -D @dhis2/config-eslint
pnpm add -D @dhis2/config-prettier

pnpx husky init

echo "pnpm lint-staged" > .husky/pre-commit

rm .prettierrc.js
echo "import prettierConfig from '@dhis2/config-prettier'\n\n/**\n * @type {import(\"prettier\").Config}\n */\nconst config = {\n    ...prettierConfig,\n}\n\nexport default config" > ./.prettierrc.mjs

rm .eslintrc.js
echo "import config from '@dhis2/config-eslint'\nimport { defineConfig } from 'eslint/config'\nimport { includeIgnoreFile } from '@eslint/compat'\nimport { fileURLToPath } from 'node:url'\n\nconst gitignorePath = fileURLToPath(new URL('.gitignore', import.meta.url))\n\nexport default defineConfig([\n    includeIgnoreFile(gitignorePath, 'Imported .gitignore patterns'),\n    {\n        extends: [config],\n    },\n])\n" > ./eslint.config.mjs

npm pkg set 'scripts.prepare'='husky'

npm pkg set 'scripts.lint'='pnpm tsc && eslint && prettier -c .'
npm pkg set 'lint-staged.*'='["pnpm prettier . --write","pnpm lint"]' --json

pnpm prettier . --write