#!/bin/bash
set -euo pipefail

sudo pacman -S --needed --noconfirm docker docker-compose
sudo systemctl enable --now docker.service

if ! groups "$USER" | grep -qw docker; then
  sudo usermod -aG docker "$USER"
fi

exec sg docker newgrp "$(id -gn)"

echo "Docker installation complete!"
