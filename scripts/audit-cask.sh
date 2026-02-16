#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CASK_NAME="${CASK_NAME:-vde-notifier-app}"
CASK_PATH="${REPO_ROOT}/Casks/${CASK_NAME}.rb"
AUDIT_TAP_NAME="${AUDIT_TAP_NAME:-local/vde-notifier}"

brew style "${CASK_PATH}"

if ! git -C "${REPO_ROOT}" rev-parse --verify HEAD >/dev/null 2>&1; then
  echo "skip brew audit: no commits in repository yet"
  exit 0
fi

added_tap=0
if ! brew tap | rg -xq "${AUDIT_TAP_NAME}"; then
  brew tap "${AUDIT_TAP_NAME}" "${REPO_ROOT}" >/dev/null
  added_tap=1
fi

cleanup() {
  if [[ "${added_tap}" -eq 1 ]]; then
    brew untap "${AUDIT_TAP_NAME}" >/dev/null 2>&1 || true
  fi
}
trap cleanup EXIT

brew audit --cask --strict --online --no-signing "${AUDIT_TAP_NAME}/${CASK_NAME}"
