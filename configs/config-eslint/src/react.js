import eslintReact from '@eslint-react/eslint-plugin'
import { defineConfig } from 'eslint/config'
import pluginReactHook from 'eslint-plugin-react-hooks'
import baseConfig from './index.js'

export default defineConfig([
    baseConfig,
    eslintReact.configs.recommended,
    pluginReactHook.configs.flat.recommended,
    {
        rules: {
            'react-hooks/refs': 'off',
            'react-hooks/set-state-in-effect': 'off',
            'react-hooks/rules-of-hooks': 'error',
            'react-hooks/exhaustive-deps': 'warn',
            '@eslint-react/no-unstable-default-props': 'error',
        },
    },
])
