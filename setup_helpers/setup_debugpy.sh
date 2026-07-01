#!/usr/bin/env bash
set -euo pipefail
 
DEBUGPY_VENV="$HOME/.virtualenvs/debugpy"

# --- Debugpy venv ---
if [ ! -d "$DEBUGPY_VENV" ]; then
  echo "Creating debugpy venv at $DEBUGPY_VENV..."
  python3 -m venv "$DEBUGPY_VENV"
else
  echo "Debugpy venv already exists."
fi
 
# Always (re)install deps — idempotent, and fixes a recreated/empty venv
echo "Installing debugpy into debugpy venv..."
"$DEBUGPY_VENV/bin/pip" install --upgrade pip
"$DEBUGPY_VENV/bin/pip" install --upgrade debugpy
 
echo ""
echo "Debugpy ready at $DEBUGPY_VENV."
