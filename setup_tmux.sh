#!/usr/bin/env bash

PLUGIN_DIR="$HOME/.config/tmux/plugins/catppuccin/tmux"
CONFIG_DIR="$HOME/.config/tmux"
TMUX_CONF="$CONFIG_DIR/tmux.conf"
REPO_URL="https://github.com/catppuccin/tmux.git"
BRANCH="main"
RUN_LINE="run \"$PLUGIN_DIR/catppuccin.tmux\""

mkdir -p "$(dirname "$PLUGIN_DIR")"

if [ -d "$PLUGIN_DIR/.git" ]; then
    git -C "$PLUGIN_DIR" fetch --all
    git -C "$PLUGIN_DIR" checkout "$BRANCH"
    git -C "$PLUGIN_DIR" pull origin "$BRANCH"
else
    git clone -b "$BRANCH" "$REPO_URL" "$PLUGIN_DIR"
fi

mkdir -p "$CONFIG_DIR"
touch "$TMUX_CONF"

grep -qxF "$RUN_LINE" "$TMUX_CONF" || echo "$RUN_LINE" >> "$TMUX_CONF"

echo "Done"
