#!/usr/bin/env bash
# Install this folder's Claude Code config into ~/.claude, global for all
# projects. Linux and macOS. Safe to re-run: correct links are left alone,
# anything replaced is kept as <name>.bak.<timestamp>.
set -euo pipefail

src_dir=$(cd "$(dirname "$0")" && pwd -P)
dst_dir="$HOME/.claude"
stamp=$(date +%Y%m%d-%H%M%S)

if ! command -v jq >/dev/null 2>&1; then
    echo "error: jq not found. Install it first: sudo apt install jq | brew install jq" >&2
    exit 1
fi

mkdir -p "$dst_dir"

link() {
    local src="$src_dir/$1" dst="$dst_dir/$1"
    # -ef compares the resolved files, so a link through a symlinked path still counts.
    if [ -L "$dst" ] && [ "$dst" -ef "$src" ]; then
        echo "ok      $dst"
        return
    fi
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mv "$dst" "$dst.bak.$stamp"
        echo "backup  $dst -> $dst.bak.$stamp"
    fi
    ln -s "$src" "$dst"
    echo "link    $dst -> $src"
}

link CLAUDE.md
link statusline.sh

# Merged, not linked: ~/.claude/settings.json also holds per-machine state
# (permissions, model, plugins) that does not belong in the repo. Top-level
# keys in the repo's settings.json replace the local ones whole, so no stale
# sub-keys survive (e.g. an old statusLine.padding).
settings="$dst_dir/settings.json"
if [ ! -e "$settings" ]; then
    cp "$src_dir/settings.json" "$settings"
    echo "create  $settings"
else
    merged=$(jq -s '.[0] + .[1]' "$settings" "$src_dir/settings.json")
    if [ "$merged" = "$(jq . "$settings")" ]; then
        echo "ok      $settings"
    else
        cp "$settings" "$settings.bak.$stamp"
        printf '%s\n' "$merged" > "$settings"
        echo "merge   $settings (backup $settings.bak.$stamp)"
    fi
fi
