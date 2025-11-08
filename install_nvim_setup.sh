#!/bin/bash
set -euo pipefail

sudo pacman -S --noconfirm ripgrep fd python-lsp-server clang unzip

mkdir -p ~/.config/nvim

curl -fsSL https://raw.githubusercontent.com/cliffordwilliam/dotfiles/main/init.lua -o ~/.config/nvim/init.lua

echo "Neovim setup complete!"
