#!/usr/bin/env bash
set -euo pipefail

GHOSTTY_CONF_DIR="$HOME/.config/ghostty"
GHOSTTY_CONF="$GHOSTTY_CONF_DIR/config"

mkdir -p "$GHOSTTY_CONF_DIR"

cat > "$GHOSTTY_CONF" <<'EOF'
theme = TokyoNight
background-opacity = 0.8
background-blur = 20
EOF

echo "Ghostty configured."
