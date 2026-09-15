# @dhis2/config-lslint

Shareable `ls-lint` config for DHIS2 organisation.

Unlike `@dhis2/config-eslint`/`@dhis2/config-prettier`/`@dhis2/config-commitlint`,
[`ls-lint`](https://ls-lint.org) has no `extends`/import mechanism — it only reads a single
`.ls-lint.yml` file per project, so this package can't be imported the same way the others
are. Instead, it publishes a versioned, canonical copy of the ruleset that a setup script (or
you, by hand) copies into the consuming project's own `.ls-lint.yml`:

```sh
cp node_modules/@dhis2/config-lslint/src/ls-lint.yml .ls-lint.yml
```

This still gets you a single source of truth with changelogged updates — just propagated by
copying rather than importing.
