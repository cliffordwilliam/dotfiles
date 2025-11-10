#!/usr/bin/env bash
set -euo pipefail

PICOM_CONF_DIR="$HOME/.config/picom"
PICOM_CONF="$PICOM_CONF_DIR/picom.conf"
XINITRC="$HOME/.xinitrc"
PICOM_CMD="picom &"

sudo pacman -Sy --noconfirm picom

mkdir -p "$PICOM_CONF_DIR"

cat > "$PICOM_CONF" <<'EOF'
backend = "glx";
fading = true;
fade-in-step = 0.08;
fade-out-step = 0.08;
inactive-opacity = 0.80;
active-opacity = 0.80;
frame-opacity = 0.80;
blur-method = "dual_kawase";
strength = 2;
vsync = true;
EOF

touch "$XINITRC"
sed -i '/picom/d' "$XINITRC"
sed -i "1i $PICOM_CMD" "$XINITRC"

echo "Done"
