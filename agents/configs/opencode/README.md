# OpenCode Config

`../shared/mcp.servers.json` is the source of truth for MCP servers.

`agents/scripts/sync-mcp.mjs` replaces only the top-level `"mcp"` object inside
`~/.config/opencode/opencode.jsonc`. Provider settings, permissions, tools, and
plugins remain in the live OpenCode config.

OpenCode MCP headers are rendered into the local config because OpenCode treats
headers as literal strings. Keep secret values in `~/.config/agents/secrets.env`
or in the existing local config; never commit rendered configs with secrets.
