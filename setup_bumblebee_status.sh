#!/usr/bin/env bash
set -euo pipefail

BUMBLE_DIR="$HOME/.config/bumblebee-status"
I3CONF="$HOME/.config/i3/config"
REPO_URL="https://github.com/tobi-wan-kenobi/bumblebee-status.git"
BRANCH="main"

BAR_BLOCK=$(cat <<'EOF'
bar {
    status_command python3 ~/.config/bumblebee-status/bumblebee-status \
        -m memory battery date time \
        -t moonlight-powerline
}
EOF
)

mkdir -p "$(dirname "$BUMBLE_DIR")"
mkdir -p "$(dirname "$I3CONF")"

if [ -d "$BUMBLE_DIR/.git" ]; then
    git -C "$BUMBLE_DIR" fetch --all
    git -C "$BUMBLE_DIR" checkout "$BRANCH"
    git -C "$BUMBLE_DIR" pull origin "$BRANCH"
else
    git clone -b "$BRANCH" "$REPO_URL" "$BUMBLE_DIR"
fi

touch "$I3CONF"

sed -i '/^bar\s*{/,/^}/d' "$I3CONF"

printf "\n%s\n" "$BAR_BLOCK" >> "$I3CONF"

echo "Done"
