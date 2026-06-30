#!/usr/bin/env bash
set -euo pipefail

NVIM_VENV="$HOME/.virtualenvs/neovim"

# --- Ensure python3 exists (platform-specific) ---
if ! command -v python3 &>/dev/null; then
  echo "python3 not found; installing..."
  if command -v brew &>/dev/null; then
    brew install python
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y python3
  else
    echo "No supported package manager found; install python3 manually." >&2
    exit 1
  fi
fi

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

# --- ImageMagick (image.nvim's magick_cli processor) ---
if ! command -v magick &>/dev/null && ! command -v convert &>/dev/null; then
  echo "Installing ImageMagick..."
  if command -v brew &>/dev/null; then
    brew install imagemagick
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y ImageMagick
  else
    echo "No supported package manager found; install ImageMagick manually." >&2
    exit 1
  fi
else
  echo "ImageMagick already installed."
fi

echo ""
echo "Molten dependencies ready."
echo "NOTE: After launching Neovim, run :UpdateRemotePlugins and restart"
echo "      so molten registers its remote plugin against this provider."
