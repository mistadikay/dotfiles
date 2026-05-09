# Agents

Shared personal agent tooling.

Run:

```bash
~/.dotfiles/agents/sync.sh
```

Preview changes first:

```bash
~/.dotfiles/agents/sync.sh --dry-run
```

The sync command currently manages:

- skills into `~/.claude/skills` and `~/.codex/skills`
- MCP servers from `configs/shared/mcp.servers.json`
- Codex MCP config in a marked block of `~/.codex/config.toml`
- OpenCode's top-level `"mcp"` config in `~/.config/opencode/opencode.jsonc`
- common `mcpServers` JSON files for Claude Code, Cursor, Junie, Gemini
  Antigravity, generic `~/.ai/mcp`, and GitHub Copilot for IntelliJ when those
  local config paths exist

## Secrets

Do not commit secret values. Put them in:

```bash
~/.config/agents/secrets.env
```

Start from:

```bash
mkdir -p ~/.config/agents
cp ~/.dotfiles/agents/configs/shared/secrets.env.example ~/.config/agents/secrets.env
chmod 600 ~/.config/agents/secrets.env
```

The sync script uses environment variables first, then `secrets.env`, then
already-rendered values from existing local harness configs when it can preserve
them.

## Adding Things

Add a new skill under `skills/<name>/SKILL.md`, or add an MCP server to
`configs/shared/mcp.servers.json`, then run:

```bash
~/.dotfiles/agents/sync.sh
```
