# homebrew-vde-notifier

This tap distributes Homebrew artifacts for `vde-notifier`.

Currently provided:

- `vde-notifier-app` (Cask)

## Installation

```bash
brew tap yuki-yano/vde-notifier
brew install --cask yuki-yano/vde-notifier/vde-notifier-app
```

After installation, confirm the app/CLI is available:

```bash
vde-notifier-app doctor
```

## Release Workflow

The cask tracks the `latest` release asset from `yuki-yano/vde-notifier`.
Always publish the asset with this exact filename:

- `VdeNotifierApp.app.tar.gz`

Preferred method: use the release workflow in `yuki-yano/vde-notifier`:

- `.github/workflows/release-vde-notifier-app.yml`

1. Create and push a tag in `yuki-yano/vde-notifier`:

```bash
git tag v0.1.0
git push origin v0.1.0
```

2. Wait for `release-vde-notifier-app` workflow to complete.
3. Confirm the GitHub release contains `VdeNotifierApp.app.tar.gz`.

Use the same asset filename for every subsequent release.

## Local Validation

```bash
./scripts/audit-cask.sh
```

Note: `brew audit` requires the repository to be clonable as a tap.
If this repository has no commit yet, the script runs style checks and skips `brew audit`.

To force a local reinstall test:

```bash
brew install --cask --force yuki-yano/vde-notifier/vde-notifier-app
```
