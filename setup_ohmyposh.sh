#!/usr/bin/env bash

set -euo pipefail

HOME_DIR="$HOME"
CONFIG_DIR="$HOME_DIR/.config/oh-my-posh"
CONFIG_FILE="$CONFIG_DIR/catppuccin_mocha.omp.json"
BASHRC="$HOME_DIR/.bashrc"

curl -s https://ohmyposh.dev/install.sh | bash -s

if ! grep -Fxq 'export PATH=$PATH:$HOME/.local/bin' "$BASHRC"; then
    echo 'export PATH=$PATH:$HOME/.local/bin' >> "$BASHRC"
fi

export PATH=$PATH:$HOME/.local/bin

eval "$(oh-my-posh init bash)"

oh-my-posh font install Meslo

mkdir -p "$CONFIG_DIR"

curl -fsSL https://raw.githubusercontent.com/cliffordwilliam/dotfiles/main/catppuccin_mocha.omp.json -o "$CONFIG_FILE"

EVAL_LINE="eval \"\$(oh-my-posh init bash --config $CONFIG_FILE)\""
if ! grep -Fxq "$EVAL_LINE" "$BASHRC"; then
    echo "$EVAL_LINE" >> "$BASHRC"
fi

echo "Success! Reloading Bash..."
exec bash

