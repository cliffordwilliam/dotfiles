#!/usr/bin/env bash
set -euo pipefail

git config --global core.editor "nvim"
git config --global user.name "Clifford William"
git config --global user.email "ccliffordwilliam@gmail.com"
git config --global init.defaultBranch main
git config --global pull.rebase false

sudo pacman -Sy --needed --noconfirm openssh github-cli

ssh-keygen -t ed25519

gh auth login

echo "Done"
