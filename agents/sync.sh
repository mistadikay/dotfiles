#!/usr/bin/env bash
#
# Sync dotfile-owned agent assets into local agent harnesses.

set -euo pipefail

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target="${1:-all}"

case "$target" in
  all|skills|mcp)
    shift || true
    ;;
  --help|-h|help)
    cat <<'USAGE'
Usage: ~/.dotfiles/agents/sync.sh [all|skills|mcp] [--dry-run]

Targets:
  all      Sync skills and MCP configuration (default)
  skills   Symlink shared skills into local agent harnesses
  mcp      Sync shared MCP servers into local agent harness configs

Secrets:
  Put local-only values in ~/.config/agents/secrets.env.
  See agents/configs/shared/secrets.env.example.
USAGE
    exit 0
    ;;
  *)
    # Let flags like --dry-run mean "all --dry-run".
    target="all"
    ;;
esac

if [ "$target" = "all" ] || [ "$target" = "skills" ]; then
  "$dir/scripts/sync-skills.sh" "$@"
fi

if [ "$target" = "all" ] || [ "$target" = "mcp" ]; then
  node "$dir/scripts/sync-mcp.mjs" "$@"
fi
