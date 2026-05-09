#!/usr/bin/env bash
#
# Backwards-compatible entrypoint for agent tooling setup.

set -euo pipefail

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$dir/sync.sh" "$@"
