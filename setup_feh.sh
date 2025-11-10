#!/usr/bin/env bash
set -euo pipefail

IMG_NAME="b-422.png"
IMG_URL="https://raw.githubusercontent.com/cliffordwilliam/dotfiles/main/$IMG_NAME"
IMG_DIR="$HOME/images"
IMG_PATH="$IMG_DIR/$IMG_NAME"
XINITRC="$HOME/.xinitrc"
FEH_CMD="feh --bg-fill \"$IMG_PATH\""

sudo pacman -Sy --noconfirm feh

mkdir -p "$IMG_DIR"

curl -L "$IMG_URL" -o "$IMG_PATH"

touch "$XINITRC"

grep -qxF "$FEH_CMD" "$XINITRC" || echo "$FEH_CMD" >> "$XINITRC"

echo "Done"
