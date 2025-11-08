#!/bin/bash
set -euo pipefail

sudo pacman -S --noconfirm ripgrep fd python-lsp-server clang unzip

if command -v npm >/dev/null 2>&1; then
  npm install -g typescript typescript-language-server
else
  echo "npm not found in this session, ts lsp deps are not installed!"
fi

mkdir -p ~/.config/nvim

curl -fsSL https://raw.githubusercontent.com/cliffordwilliam/dotfiles/main/init.lua -o ~/.config/nvim/init.lua

echo "Neovim setup complete!"
