#!/usr/bin/env bash
set -euo pipefail


# --- Clone zsh-vi-mode on linux ---
if [[ "$(uname)" == "Linux" ]]; then
  ZSH_VI_MODE_DIR="${HOME}/.local/share/zsh-vi-mode"
  if [ ! -d "$ZSH_VI_MODE_DIR" ]; then
    git clone --depth 1 -- https://github.com/jeffreytse/zsh-vi-mode.git "$ZSH_VI_MODE_DIR"
  fi
fi


# --- ImageMagick (required by image.nvim's magick_cli processor) ---
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
  echo "ImageMagick already installed; skipping."
fi


# --- Neovim Python provider venv (for molten-nvim) ---
NVIM_VENV="$HOME/.virtualenvs/neovim"

if [ ! -d "$NVIM_VENV" ]; then
  echo "Creating Neovim provider venv at $NVIM_VENV..."

  # Make sure python3 is available (platform-specific install)
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

  python3 -m venv "$NVIM_VENV"
  "$NVIM_VENV/bin/pip" install --upgrade pip
  "$NVIM_VENV/bin/pip" install pynvim jupyter_client nbformat pillow pyperclip cairosvg pnglatex plotly kaleido
  echo "Neovim provider venv ready."
else
  echo "Neovim provider venv already exists; skipping."
fi


# Go to the dotfiles directory
cd "$(dirname "${BASH_SOURCE[0]}")"

# Create config symlinks
stow --target="$HOME" --restow .
