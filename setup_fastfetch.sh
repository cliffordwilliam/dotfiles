#!/usr/bin/env bash
set euo pipefail

IMG_NAME="logo.png"
IMG_URL="https://raw.githubusercontent.com/cliffordwilliam/dotfiles/main/$IMG_NAME"
IMG_DIR="$HOME/images"
IMG_PATH="$IMG_DIR/$IMG_NAME"
BASHRC="$HOME/.bashrc"

sudo pacman -Sy --noconfirm fastfetch

mkdir -p "$IMG_DIR"

curl -L "$IMG_URL" -o "$IMG_PATH"

sed -i "\|^fastfetch$|d" "$BASHRC"

echo "fastfetch --logo \"$IMG_PATH\" --logo-type kitty-direct --logo-padding-left 1 --logo-padding-right 1 --logo-padding-top 1" >> "$BASHRC"

echo "Done"
