# Codex Config

`../shared/mcp.servers.json` is the source of truth for MCP servers.

`agents/scripts/sync-mcp.mjs` updates only a marked MCP block inside
`~/.codex/config.toml`. Codex-owned state, project trust entries, plugins, and
other settings stay outside that block.
