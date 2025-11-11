#!/usr/bin/env bash
set -euo pipefail

I3CONF="$HOME/.config/i3/config"

mkdir -p "$(dirname "$I3CONF")"
touch "$I3CONF"

sed -i '/^default_border/d' "$I3CONF"
sed -i '/^default_floating_border/d' "$I3CONF"

sed -i '1idefault_floating_border pixel 0' "$I3CONF"
sed -i '1idefault_border pixel 0' "$I3CONF"

echo "Done"
