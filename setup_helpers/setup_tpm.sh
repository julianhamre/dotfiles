#!/usr/bin/env bash
set -euo pipefail

TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ -d "$TPM_DIR" ]; then
  echo "TPM already installed."
else
  echo "Installing TPM..."
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
  echo "TPM installed. Launch tmux and press prefix + I to install plugins."
fi
