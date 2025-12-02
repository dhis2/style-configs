import { defineConfig } from "eslint/config";

import pluginReact from "eslint-plugin-react";
import pluginReactHook from "eslint-plugin-react-hooks";

import baseConfig from "./index.js";
import importPlugin from "eslint-plugin-import";

export default defineConfig([
  baseConfig,
  pluginReact.configs.flat.recommended,
  pluginReact.configs.flat['jsx-runtime'],
  pluginReactHook.configs.flat.recommended,
  {
    rules: {
      "react-hooks/refs": "off",
      "react-hooks/set-state-in-effect": "off",
      "react-hooks/rules-of-hooks": "error",
      "react-hooks/exhaustive-deps": "warn",
      "react/sort-prop-types": [
        "error",
        {
          requiredFirst: true,
          sortShapeProp: true,
          callbacksLast: true,
        },
      ],
      "react/no-unused-prop-types": "error",
      "react/no-object-type-as-default-prop": "error",
    },
  },
]);
