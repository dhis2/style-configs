import { defineConfig, globalIgnores } from "eslint/config";
import tsParser from "@typescript-eslint/parser";
import tseslint from "typescript-eslint";
import importPlugin from "eslint-plugin-import";
import globals from "globals";
import js from "@eslint/js";
import eslintConfigPrettier from "eslint-config-prettier/flat";

export default defineConfig([
  { files: ["src/**/*.{js,mjs,cjs,ts,mts,cts,jsx,tsx}"] },

  js.configs.recommended,
  {
    files: ["**/*.{ts,tsx}"],
    extends: [tseslint.configs.recommended],
    rules: {
      "import/extensions": "off",
      "no-unused-vars": "off",
      "@typescript-eslint/no-unused-vars": [
        "error",
        {
          varsIgnorePattern: "^React",
        },
      ],
    },
  },
  eslintConfigPrettier,
  importPlugin.flatConfigs.errors,
  {
    languageOptions: {
      globals: {
        ...globals.browser,
        ...globals.node,
        ...globals.jest,
      },

      parser: tsParser,
      ecmaVersion: 2018,
      sourceType: "module",

      parserOptions: {
        ecmaFeatures: {
          jsx: true,
        },
      },
    },

    settings: {
      react: { version: "detect" },
      // Prevents "error: unable to resolve module X" for .jsx files
      // if .jsx extension isn't used, e.g.
      // `import Component from './component'`
      "import/resolver": {
        node: { extensions: [".js", ".mjs", ".jsx", ".ts", ".tsx"] },
      },
    },
  },
  {
    rules: {
      "max-params": [
        "error",
        {
          max: 3,
        },
      ],

      "prefer-const": [
        "error",
        {
          destructuring: "any",
          ignoreReadBeforeAssign: false,
        },
      ],

      "no-mixed-spaces-and-tabs": ["error"],

      "import/order": [
        "error",
        {
          "newlines-between": "never",

          alphabetize: {
            order: "asc",
            caseInsensitive: true,
          },
        },
      ],

      curly: ["error"],
      "no-unused-vars": [
        "error",
        {
          varsIgnorePattern: "React",
        },
      ],
      "no-unused-vars": [
        "error",
        {
          varsIgnorePattern: "^React",
        },
      ],
    },
  },
  globalIgnores([
    ".d2/**/*",
    "build/**/*",
    "src/locales/**/*",
    "eslint.config*",
    "./*.js",
  ]),
]);
