#!/data/data/com.termux/files/usr/bin/bash
# Uninstall Claude Code to allow clean reinstall via install.sh
set -euo pipefail

echo "=> removing claude code"
npm uninstall -g @anthropic-ai/claude-code 2>/dev/null || true

echo "=> clearing npm cache"
npm cache clean --force 2>/dev/null || true

echo "=> clearing npm proxy config"
npm config delete proxy 2>/dev/null || true
npm config delete https-proxy 2>/dev/null || true

echo ""
echo "done. now run: bash install.sh"
