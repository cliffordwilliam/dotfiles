#!/bin/bash
set -euo pipefail

SSH_KEY_PATH="$HOME/.ssh/id_ed25519"
KEY_TITLE="$(cut -c1-8 /etc/machine-id)-$(hostname)"

git config --global core.editor "nvim"
git config --global user.name "Clifford William"
git config --global user.email "ccliffordwilliam@gmail.com"
git config --global init.defaultBranch main
git config --global pull.rebase false

sudo pacman -S --needed --noconfirm openssh github-cli

if [[ ! -f "$SSH_KEY_PATH" ]]; then
  ssh-keygen -t ed25519
fi

if ! gh auth status >/dev/null 2>&1; then
  gh auth login
fi

gh ssh-key add "$SSH_KEY_PATH.pub" --title "$KEY_TITLE"

echo "Git and GitHub setup complete!"
