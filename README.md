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

If macOS blocks the app because it is unsigned, run:

```bash
xattr -dr com.apple.quarantine /Applications/VdeNotifierApp.app
```

## Release Workflow

The cask is pinned by `version` and `sha256` in `Casks/vde-notifier-app.rb`.
Automation updates these values for each app release.

Fixed asset filename:

- `VdeNotifierApp.app.tar.gz`

Workflows:

- `.github/workflows/update-cask.yml` (this repository)
- `.github/workflows/release-vde-notifier-app.yml`

### Standard flow

1. Create and push an app tag in `yuki-yano/vde-notifier`:

```bash
git tag app-v0.1.1
git push origin app-v0.1.1
```

2. Wait for `release-vde-notifier-app` to upload `VdeNotifierApp.app.tar.gz`.
3. Wait for `update-cask` to update `version` and `sha256` in this tap.
4. Confirm the cask update commit is pushed.

### Manual recovery

If you need to update the cask manually:

```bash
gh workflow run update-cask.yml \
  -R yuki-yano/homebrew-vde-notifier \
  -f version=0.1.1 \
  -f sha256=<sha256>
```

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
