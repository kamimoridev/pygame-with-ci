#!/usr/bin/env bash
set -euo pipefail

# Build the project with PyInstaller

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
ROOT_DIR="$(cd -- "${SCRIPT_DIR}/.." >/dev/null 2>&1 && pwd)"

# Configurables via env
APP_NAME=${APP_NAME:-pygato}
ENTRY=${ENTRY:-main.py}
DIST_DIR=${DIST_DIR:-"${ROOT_DIR}/dist/pyinstaller"}
BUILD_DIR=${BUILD_DIR:-"${ROOT_DIR}/build/pyinstaller"}

cd "$ROOT_DIR"

echo "[pyinstaller] Building ${APP_NAME} from ${ENTRY}..."

uv run pyinstaller \
  --name "$APP_NAME" \
  --onefile \
  --windowed \
  --noconfirm \
  --clean \
  --distpath "$DIST_DIR" \
  --workpath "$BUILD_DIR" \
  --paths "$ROOT_DIR" \
  --collect-all pygame \
  --collect-submodules pygame \
  --hidden-import=pygame \
  --hidden-import=pygame.freetype \
  --hidden-import=pygame._sdl2 \
  "$ENTRY"

echo "[pyinstaller] Done. Binary at: ${DIST_DIR}/${APP_NAME}"
