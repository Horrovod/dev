#!/data/data/com.termux/files/usr/bin/bash
# Install Claude Code in Termux with optional proxy support.
# Usage: bash install.sh [proxy_url]
# Example: bash install.sh socks5://127.0.0.1:1080
set -euo pipefail

PROXY="${1:-http://user324478:4rumtz@5.180.50.29:9286}"
SHELL_RC="$HOME/.zshrc"
[ ! -f "$SHELL_RC" ] && SHELL_RC="$HOME/.bashrc"

SETPROXY_FN='
# --- setproxy (added by termux/install.sh) ---
setproxy() {
  if [ -z "${1:-}" ]; then
    echo "Usage: setproxy <proxy_url> | off"
    return 1
  fi
  if [ "$1" = "off" ]; then
    unset http_proxy https_proxy all_proxy HTTP_PROXY HTTPS_PROXY ALL_PROXY
    echo "Proxy disabled"
    return 0
  fi
  export http_proxy="$1"
  export https_proxy="$1"
  export all_proxy="$1"
  export HTTP_PROXY="$1"
  export HTTPS_PROXY="$1"
  export ALL_PROXY="$1"
  echo "Proxy set to $1"
}
# ---'

# Apply proxy for this session if provided
if [ -n "$PROXY" ]; then
  export http_proxy="$PROXY"
  export https_proxy="$PROXY"
  export all_proxy="$PROXY"
  export HTTP_PROXY="$PROXY"
  export HTTPS_PROXY="$PROXY"
  export ALL_PROXY="$PROXY"
  npm config set proxy "$PROXY"
  npm config set https-proxy "$PROXY"
  echo "=> proxy: $PROXY"
fi

echo "=> updating packages"
pkg update -y && pkg upgrade -y

echo "=> installing nodejs"
pkg install -y nodejs

echo "=> installing claude code"
npm install -g @anthropic-ai/claude-code

# Add setproxy function to shell config if not already there
if ! grep -q "setproxy" "$SHELL_RC" 2>/dev/null; then
  echo "$SETPROXY_FN" >> "$SHELL_RC"
  echo "=> setproxy added to $SHELL_RC"
else
  echo "=> setproxy already in $SHELL_RC, skipping"
fi

echo ""
echo "done. restart shell or run: source $SHELL_RC"
echo "then: claude"
