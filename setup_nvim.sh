#!/usr/bin/env bash
set -euo pipefail

sudo pacman -Sy --noconfirm ripgrep fd python-lsp-server clang unzip

if command -v npm >/dev/null 2>&1; then
  npm install -g typescript typescript-language-server
else
  echo "This session does not have npm, TS LSP dependencies are not installed"
fi

mkdir -p ~/.config/nvim

curl -fsSL https://raw.githubusercontent.com/cliffordwilliam/dotfiles/main/init.lua -o ~/.config/nvim/init.lua

curl -fsSL https://raw.githubusercontent.com/cliffordwilliam/dotfiles/main/Tomorrow-Night-Blue.vim -o ~/.config/nvim/colors/Tomorrow-Night-Blue.vim

echo "Done"
