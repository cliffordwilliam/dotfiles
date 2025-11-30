#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$HOME/.config/tmux"
TMUX_CONF="$CONFIG_DIR/tmux.conf"

mkdir -p "$CONFIG_DIR"
touch "$TMUX_CONF"

sed -i '/^set -g mode-keys/d' "$TMUX_CONF"
sed -i '/^set -g mouse/d' "$TMUX_CONF"
sed -i '/^bind -T copy-mode-vi Space/d' "$TMUX_CONF"
sed -i '/^bind -T copy-mode-vi Enter/d' "$TMUX_CONF"

sed -i '1iset -g mode-keys vi' "$TMUX_CONF"
sed -i '1iset -g mouse on' "$TMUX_CONF"
sed -i '1ibind -T copy-mode-vi Space send-keys -X begin-selection' "$TMUX_CONF"
sed -i '1ibind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "kitty @ clip -s"' "$TMUX_CONF"

echo "Done"
