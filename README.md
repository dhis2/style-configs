# style-configs

A monorepo for different libaries and configs that are used by the app platform.

## Dev notes

This repo uses [changesets](https://github.com/changesets/changesets) to manage versioning and changelogs.

- To prepare a changeset using conventional commits, run: `pnpm changeset-conventional`.

## Configs

- `configs/eslint-config`: publishes a shareable eslint config to `@dhis2/eslint-config` (and `@dhis2/eslint-config/react`)

- `configs/lslint-config` (ToDo)

- `configs/prettier-config` (ToDo)

- `configs/commitlint-config` (ToDo)

- `configs/stylelint-config` (ToDo)

These should replace `cli-style` eventually (context in [this ticket](https://dhis2.atlassian.net/browse/LIBS-614))

## Other parts to move to this repo (maybe)

Eventually this repo might host other parts of the platform ecosystem. Details in [this ticket](https://dhis2.atlassian.net/browse/LIBS-720):

- `cli`
- `cli-utils-library`
- `cli-helpers-engine`
- `action-semantic-release` (or a shared semantic-release config)
- `cli-utils-codemods`
- `cli-helpers-template`

| Tool                 | Company / Primary Maintainer        | Monorepo Native?           | Auto Versioning                       | Changelog | Suitable Size       | Commit Message Requirements           | Difficulty Level | Notes                                                                                   |
| -------------------- | ----------------------------------- | -------------------------- | ------------------------------------- | --------- | ------------------- | ------------------------------------- | ---------------- | --------------------------------------------------------------------------------------- |
| **Changesets**       | Community / Open‑source maintainers | ✅ Yes                      | ⚠️ Semi‑automated (manual changesets) | ✅ Yes     | Small → Large       | None (manual changeset files)         | ⭐ Easy           | Popular for JS/TS repos; human‑reviewable version bumps.                                |
| **Nx**               | Nrwl                                | ✅ Yes                      | Partial (built-in release features)   | Partial   | Small → Large       | Optional                              | ⭐ Easy           | Highly popular JS/TS build & monorepo tool; good DX and scaling.                        |
| **Semantic Release** | Community / Open‑source maintainers | ⚠️ Via plugins             | ✅ Fully automated                     | ✅ Yes     | Small → Large       | **Strict** Conventional Commits       | ⭐⭐ Medium        | Best for automated release pipelines when commit discipline is enforced.                |
| **Lerna**            | Nrwl                                | ✅ Yes                      | Optional                              | Optional  | Small → Medium      | Optional / depends on commit strategy | ⭐⭐ Medium        | Legacy JS monorepo tool; less modern ergonomics than newer tools.                       |
| **Turborepo**        | Vercel                              | ✅ Yes (workspace-based)    | Optional / via external tool          | Optional  | Small → Large       | Depends on tooling you add            | ⭐⭐ Medium        | Good for fast builds; often combined with release tooling.                              |
| **Release It!**      | Community / Open‑source maintainers | ❌ No                       | Optional                              | Optional  | Small → Medium      | Conventional Commits optional         | ⭐⭐ Medium        | Flexible, general-purpose release tool; not monorepo-native.                            |
| **Moon**             | moonrepo (open-source)              | ⚠️ Yes (build/task runner) | ❌ No built-in versioning              | ❌ No      | Medium → Large      | None                                  | ⭐⭐ Medium        | A build/task runner — not a versioning tool; usually paired with Changesets or similar. |
| **Rush + Beachball** | Microsoft                           | ✅ Yes                      | ✅ Yes                                 | ✅ Yes     | Medium → Very Large | Encouraged but depends on config      | ⭐⭐⭐ Hard         | Often used in large-scale JS/TS monorepos with many packages.                           |



| Semantic Release Step                                 | Changesets Equivalent                                         | Notes / Key Differences / GitHub Action Considerations                                                                                                                                         |
| ----------------------------------------------------- | ------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Commit code using Conventional Commits**            | **Commit normally, then run `changeset add`**                 | Changesets does not require Conventional Commits, but you can still follow them. The GitHub Action can run `changeset version` automatically without manual intervention.                      |
| **CI auto-detects version bumps**                     | **`changeset version` via GitHub Action**                     | The `changesets/action` can automatically create a commit with updated package versions and changelog whenever changesets are merged to main, mimicking Semantic Release’s auto-bump behavior. |
| **Semantic Release generates changelog**              | **Changesets generates changelog during `changeset version`** | The Action ensures the changelog updates are committed automatically; you can still review in PR if desired.                                                                                   |
| **CI commits version bump + changelog automatically** | ✅ Handled by GitHub Action                                    | Using `changesets/action@v1` you can fully automate committing version bumps and changelog updates, similar to Semantic Release.                                                               |
| **Semantic Release publishes packages automatically** | **`changeset publish` via GitHub Action**                     | The Action can run `changeset publish` on tags or after versioning, so your publish step is automated in CI like Semantic Release.                                                             |
| **CI auto-tags releases**                             | ✅ Handled by GitHub Action                                    | Tags are created automatically during `changeset publish`.                                                                                                                                     |
| **Skip release / handle pre-releases**                | **Pre-releases or skipped changesets**                        | Pre-release versions can be specified in the changeset, and the Action respects them. You can also skip publishing certain changesets.                                                         |
| **Monorepo support with plugins**                     | ✅ Built-in Changesets                                         | Works natively in monorepos; Action integrates smoothly to automate versioning and publishing per package.                                                                                     |
