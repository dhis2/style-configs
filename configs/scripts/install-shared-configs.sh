#!/usr/bin/env bash
# script for installing and using the shared config in a project that used cli-style
# CAUTION: This is a very crude script - always review the changes this script makes especially if you had custom rules in your old eslint, prettier or stylelint config. These would need to be copied manually.

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
$command add -D stylelint
$command add -D postcss-styled-jsx
$command add -D husky
$command add -D lint-staged
$command add -D @commitlint/cli
$command add -D @ls-lint/ls-lint
$command add -D @dhis2/config-eslint
$command add -D @dhis2/config-prettier
$command add -D @dhis2/config-stylelint
$command add -D @dhis2/config-commitlint
$command add -D @dhis2/config-lslint

npx husky init

echo "pnpm lint-staged" > .husky/pre-commit
echo 'npx --no -- commitlint --edit "$1"' > .husky/commit-msg

rm .prettierrc.js
echo "import prettierConfig from '@dhis2/config-prettier'\n\n/**\n * @type {import(\"prettier\").Config}\n */\nconst config = {\n    ...prettierConfig,\n}\n\nexport default config" > ./.prettierrc.mjs

rm .eslintrc.js
echo "import config from '@dhis2/config-eslint'\nimport { defineConfig } from 'eslint/config'\nimport { includeIgnoreFile } from '@eslint/compat'\nimport { fileURLToPath } from 'node:url'\n\nconst gitignorePath = fileURLToPath(new URL('.gitignore', import.meta.url))\n\nexport default defineConfig([\n    includeIgnoreFile(gitignorePath, 'Imported .gitignore patterns'),\n    {\n        extends: [config],\n    },\n])\n" > ./eslint.config.mjs

echo "import config from '@dhis2/config-stylelint'\n\n/**\n * @type {import(\"stylelint\").Config}\n */\nconst stylelintConfig = {\n    ...config,\n}\n\nexport default stylelintConfig\n" > ./stylelint.config.mjs

echo "import config from '@dhis2/config-commitlint'\n\nexport default config\n" > ./commitlint.config.mjs

# ls-lint has no extends mechanism, so the shared ruleset is referenced directly from
# node_modules on the CLI (via --config) rather than imported. This starter file is where
# you add your own project-local rules -- see node_modules/@dhis2/config-lslint/README.md
# for how composing shared + local rules works.
echo "# Project-specific ls-lint rules, layered on top of @dhis2/config-lslint's shared\n# ruleset. See node_modules/@dhis2/config-lslint/README.md for how composition works.\nls: {}\n" > ./.ls-lint.yml

npm pkg set 'scripts.prepare'='husky'

npm pkg set "scripts.lint"="eslint && prettier -c . && stylelint '**/*.{css,js,jsx,ts,tsx}' && ls-lint --config node_modules/@dhis2/config-lslint/src/ls-lint.yml --config .ls-lint.yml"
npm pkg set 'scripts.format'='prettier . -w'
npm pkg set 'lint-staged.*'='["pnpm prettier . --write","pnpm lint"]' --json

$command prettier . --write


message="Please review the changes this script makes carefully, especially if you had custom rules in your old eslint, prettier or stylelint config. These would need to be copied manually. Also double check the ls-lint rules in .ls-lint.yml match your project's actual directory layout (the shared config only scopes to src/cypress/scripts/types/lib/test/tests/e2e)."
echo "${YELLOW}${message}${NC}\n"
