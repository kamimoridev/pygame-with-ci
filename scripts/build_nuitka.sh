#!/usr/bin/env bash
set -euo pipefail

# Build the project with Nuitka

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
ROOT_DIR="$(cd -- "${SCRIPT_DIR}/.." >/dev/null 2>&1 && pwd)"

# Configurables via env
APP_NAME=${APP_NAME:-pygato}
ENTRY=${ENTRY:-main.py}
OUT_DIR=${OUT_DIR:-"${ROOT_DIR}/dist/nuitka"}

cd "$ROOT_DIR"

echo "[nuitka] Building ${APP_NAME} from ${ENTRY}..."

uv run nuitka \
  --onefile \
  --standalone \
  --assume-yes-for-downloads \
  --output-dir="$OUT_DIR" \
  --remove-output \
  --nofollow-import-to=tests \
  --output-filename="$APP_NAME" \
  "$ENTRY"

echo "[nuitka] Done. Binary at: ${OUT_DIR}/${APP_NAME}"

