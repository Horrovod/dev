#!/usr/bin/env bash
# Symlink configs from this repo into $HOME so the system picks them up
# directly from the repo. Idempotent: safe to re-run. Existing real files
# are backed up to ~/.config-backup-<timestamp>/ before being replaced.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

link() {
    local src="$REPO/$1" dst="$2"
    # already linked correctly -> nothing to do
    if [ "$(readlink -f "$dst" 2>/dev/null)" = "$src" ]; then
        echo "ok      $dst"
        return
    fi
    # back up whatever is there now (real file/dir or wrong symlink)
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mkdir -p "$BACKUP"
        mv "$dst" "$BACKUP/$(basename "$dst")"
        echo "backup  $dst -> $BACKUP/"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    echo "link    $dst -> $src"
}

# whole config directories
link hypr      "$HOME/.config/hypr"
link waybar    "$HOME/.config/waybar"
link alacritty "$HOME/.config/alacritty"
link fuzzel    "$HOME/.config/fuzzel"
link nvim      "$HOME/.config/nvim"

# single dotfiles in $HOME
link tmux/.tmux.conf   "$HOME/.tmux.conf"
link zsh/.zshrc        "$HOME/.zshrc"
link zsh/.zsh_profile  "$HOME/.zsh_profile"

echo "done"
