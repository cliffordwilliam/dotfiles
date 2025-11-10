#!/usr/bin/env bash

set -euo pipefail

HOME_DIR="$HOME"
CONFIG_DIR="$HOME_DIR/.config/oh-my-posh"
CONFIG_FILE="$CONFIG_DIR/catppuccin_mocha.omp.json"
BASHRC="$HOME_DIR/.bashrc"

curl -s https://ohmyposh.dev/install.sh | bash -s

grep -qxF 'export PATH=$PATH:$HOME/.local/bin' "$BASHRC" || \
    echo 'export PATH=$PATH:$HOME/.local/bin' >> "$BASHRC"

export PATH=$PATH:$HOME/.local/bin

oh-my-posh font install Meslo || true

mkdir -p "$CONFIG_DIR"

curl -fsSL https://raw.githubusercontent.com/cliffordwilliam/dotfiles/main/catppuccin_mocha.omp.json -o "$CONFIG_FILE"

EVAL_LINE="eval \"\$(oh-my-posh init bash --config $CONFIG_FILE)\""
grep -qxF "$EVAL_LINE" "$BASHRC" || echo "$EVAL_LINE" >> "$BASHRC"

echo "Done"
