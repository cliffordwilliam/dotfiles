#!/usr/bin/env bash
set -euo pipefail

sudo pacman -Sy --needed --noconfirm docker docker-compose
sudo systemctl enable --now docker.service

sudo usermod -aG docker "$USER"

echo "Done"
