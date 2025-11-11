#!/usr/bin/env bash
set euo pipefail

sudo pacman -Sy --noconfirm fastfetch

grep -qxF "fastfetch" "$HOME/.bashrc" || echo "fastfetch" >> "$HOME/.bashrc"

echo "Done"
