# @dhis2/config-lslint

Shareable `ls-lint` config for DHIS2 organisation.

Unlike `@dhis2/config-eslint`/`@dhis2/config-prettier`/`@dhis2/config-commitlint`,
[`ls-lint`](https://ls-lint.org) has no `extends`/import mechanism — it only reads
`.ls-lint.yml` file(s) passed on the CLI, so this package can't be imported the same way the
others are. Instead, reference it directly from `node_modules` via `ls-lint`'s support for
multiple `--config` flags (merged since v2.2.0), which it composes with your project's own
`.ls-lint.yml`:

```sh
ls-lint --config node_modules/@dhis2/config-lslint/src/ls-lint.yml --config .ls-lint.yml
```

Add that as an npm script, e.g.:

```jsonc
// package.json
"scripts": {
    "lint:filenames": "ls-lint --config node_modules/@dhis2/config-lslint/src/ls-lint.yml --config .ls-lint.yml"
}
```

This keeps you on a live link to the shared ruleset — a `pnpm update` picks up future rule
changes automatically — unlike copying the file, which forks it immediately and never updates
again.

### Adding project-local rules

Composition across configs is **additive per distinct path key, not a deep merge**: if your
`.ls-lint.yml` declares rules for a directory the shared config doesn't already cover (e.g. a
project-specific `docs/` folder), both configs' rules apply together. But if you redeclare the
_same_ path key the shared config already uses (e.g. `src`), your version **replaces** the
shared one for that key entirely rather than merging with it — the shared `src` rules would
silently stop applying.

To extend or loosen the shared rules for a subdirectory that's already covered (e.g. allow a
legacy `src/legacy` folder to keep non-kebab-case names), target a more specific nested path
instead of repeating the shared key — `ls-lint` applies the most specific matching path, so the
rest of `src` keeps the shared rules:

```yaml
# .ls-lint.yml
ls:
    src/legacy:
        .js: regex:.*
```

### Fallback: copying the file

If your project doesn't want a project-local `.ls-lint.yml` (or can't chain `--config` flags in
its setup), you can still copy the ruleset in as a one-off:

```sh
cp node_modules/@dhis2/config-lslint/src/ls-lint.yml .ls-lint.yml
```

This still gets you a single source of truth with changelogged updates at copy-time — it just
won't pick up future rule changes automatically the way the `--config` reference does, so
prefer that instead where possible.
