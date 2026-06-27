#!/usr/bin/env bash
set -euo pipefail

# Go to the dotfiles directory
cd "$(dirname "${BASH_SOURCE[0]}")"

# Clone zsh-vi-mode on linux
if [[ "$(uname)" == "Linux" ]]; then
  ZSH_VI_MODE_DIR="${HOME}/.local/share/zsh-vi-mode"
  if [ ! -d "$ZSH_VI_MODE_DIR" ]; then
    git clone --depth 1 -- https://github.com/jeffreytse/zsh-vi-mode.git "$ZSH_VI_MODE_DIR"
  fi
fi

# Create config symlinks
stow --target="$HOME" --restow .
