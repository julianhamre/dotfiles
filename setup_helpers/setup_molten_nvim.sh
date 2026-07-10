#!/usr/bin/env bash
set -euo pipefail

NVIM_VENV="$HOME/.virtualenvs/neovim"

# --- Neovim provider venv (hosts molten) ---
if [ ! -d "$NVIM_VENV" ]; then
  echo "Creating Neovim provider venv at $NVIM_VENV..."
  python3 -m venv "$NVIM_VENV"
else
  echo "Neovim provider venv already exists."
fi

# Always (re)install deps — idempotent, and fixes a recreated/empty venv
echo "Installing molten Python dependencies into provider venv..."
"$NVIM_VENV/bin/pip" install --upgrade pip
"$NVIM_VENV/bin/pip" install \
  pynvim jupyter_client \
  nbformat pillow pyperclip cairosvg pnglatex plotly kaleido

echo ""
echo "Molten dependencies ready."
echo "NOTE: After launching Neovim, run :UpdateRemotePlugins and restart"
echo "      so molten registers its remote plugin against this provider."
