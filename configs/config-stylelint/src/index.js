import postcssStyledJsx from 'postcss-styled-jsx'
import stylelintUseLogical from 'stylelint-use-logical'

/**
 * Mirrors @dhis2/cli-style's bundled stylelint config so migrating off
 * cli-style doesn't change which CSS patterns are flagged.
 *
 * Plugins/custom syntax are imported and passed as objects here rather than
 * as bare string names (cli-style's original config used
 * `plugins: ['stylelint-use-logical']` and `customSyntax: 'postcss-styled-jsx'`)
 * because a string name gets resolved via `require()` from the *consuming*
 * project's root at lint time -- which fails under pnpm's strict, non-flat
 * node_modules once this config's own dependencies aren't hoisted there.
 * Importing them directly here means stylelint receives the already-resolved
 * module, so it works regardless of how the consuming project installs its
 * dependencies. This is the same trick ESLint's flat config uses for plugins.
 */
const config = {
    overrides: [
        { files: '**/*.{js,jsx,ts,tsx}', customSyntax: postcssStyledJsx },
    ],
    plugins: [stylelintUseLogical],
    rules: {
        /**
         * Warn user when properties can't be autofixed:
         * https://github.com/csstools/stylelint-use-logical/issues/29
         */
        'declaration-property-value-disallowed-list': [
            {
                'border-color': [],
                'border-style': [],
                'border-width': [],
                inset: [],
                margin: [],
                padding: [],
                'scroll-margin': [],
                'scroll-padding': [],
            },
            {
                message: (prop) =>
                    `Use longhand form of ${prop} so that it can be autofixed to logical properties and values`,
                severity: 'warning',
            },
        ],
        'csstools/use-logical': [
            true,
            {
                severity: 'warning',
            },
        ],
    },
}

export default config
