#!/usr/bin/env bash
# script for installing and using the shared config in a project that used cli-style
# CAUTION: This is a very crude script - always review the changes this script makes especially if you had custom rules in your old eslint or prettier config. These would need to be copied manually.

# To run it, you can do: curl -s https://raw.githubusercontent.com/dhis2/style-configs/refs/heads/main/configs/scripts/install-shared-configs.sh | sh -s -- yarn

YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

if [ "$#" -eq 0 ]; then
    echo "${RED}No arguments provided. Please pass either 'yarn' or 'pnpm' depending on which package manager you use. For example:\nsh ./install-shared-configs.sh yarn${NC}"
    exit 1
fi

command=$1

$command add -D eslint
$command add -D @eslint/compat
$command add -D prettier
$command add -D husky
$command add -D lint-staged
$command add -D @dhis2/config-eslint
$command add -D @dhis2/config-prettier

npx husky init

echo "pnpm lint-staged" > .husky/pre-commit

rm .prettierrc.js
echo "import prettierConfig from '@dhis2/config-prettier'\n\n/**\n * @type {import(\"prettier\").Config}\n */\nconst config = {\n    ...prettierConfig,\n}\n\nexport default config" > ./.prettierrc.mjs

rm .eslintrc.js
echo "import config from '@dhis2/config-eslint'\nimport { defineConfig } from 'eslint/config'\nimport { includeIgnoreFile } from '@eslint/compat'\nimport { fileURLToPath } from 'node:url'\n\nconst gitignorePath = fileURLToPath(new URL('.gitignore', import.meta.url))\n\nexport default defineConfig([\n    includeIgnoreFile(gitignorePath, 'Imported .gitignore patterns'),\n    {\n        extends: [config],\n    },\n])\n" > ./eslint.config.mjs

npm pkg set 'scripts.prepare'='husky'

npm pkg set 'scripts.lint'='eslint && prettier -c .'
npm pkg set 'scripts.format'='prettier . -w'
npm pkg set 'lint-staged.*'='["pnpm prettier . --write","pnpm lint"]' --json

$command prettier . --write


message="Please review the changes this script makes carefully, especially if you had custom rules in your old eslint or prettier config. These would need to be copied manually."
echo "${YELLOW}${message}${NC}\n"
