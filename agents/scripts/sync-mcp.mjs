#!/usr/bin/env node

import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { fileURLToPath } from "node:url";

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const agentsDir = path.resolve(scriptDir, "..");
const registryPath = path.join(agentsDir, "configs", "shared", "mcp.servers.json");
const dryRun = process.argv.includes("--dry-run");
const home = os.homedir();
const stateDir = path.join(home, ".config", "agents", "state");
const managedNames = [];
const warnings = new Set();

const registry = JSON.parse(fs.readFileSync(registryPath, "utf8"));
const servers = Object.entries(registry.servers ?? {}).filter(([, server]) => server.enabled !== false);
for (const [name] of servers) managedNames.push(name);

const secrets = loadSecrets();

const targets = [
  {
    name: "codex",
    path: "~/.codex/config.toml",
    kind: "codex",
    presence: "~/.codex"
  },
  {
    name: "opencode",
    path: "~/.config/opencode/opencode.jsonc",
    kind: "opencode",
    presence: "~/.config/opencode"
  },
  {
    name: "claude",
    path: "~/.claude.json",
    kind: "mcp-json",
    topKey: "mcpServers",
    style: "claude",
    presence: "~/.claude"
  },
  {
    name: "cursor",
    path: "~/.cursor/mcp.json",
    kind: "mcp-json",
    topKey: "mcpServers",
    style: "generic"
  },
  {
    name: "junie",
    path: "~/.junie/mcp/mcp.json",
    kind: "mcp-json",
    topKey: "mcpServers",
    style: "generic"
  },
  {
    name: "gemini-antigravity",
    path: "~/.gemini/antigravity/mcp_config.json",
    kind: "mcp-json",
    topKey: "mcpServers",
    style: "generic"
  },
  {
    name: "generic-ai",
    path: "~/.ai/mcp/mcp.json",
    kind: "mcp-json",
    topKey: "mcpServers",
    style: "generic"
  },
  {
    name: "github-copilot-intellij",
    path: "~/.config/github-copilot/intellij/mcp.json",
    kind: "mcp-json",
    topKey: "servers",
    style: "copilot"
  }
];

console.log("Syncing MCP servers");

for (const target of targets) {
  const targetPath = expandHome(target.path);
  if (!targetExists(target, targetPath)) {
    console.log(`  - ${target.name} skipped; ${target.path} does not exist`);
    continue;
  }

  if (target.kind === "codex") {
    syncCodex(target, targetPath);
  } else if (target.kind === "opencode") {
    syncOpenCode(target, targetPath);
  } else {
    syncMcpJson(target, targetPath);
  }
}

if (warnings.size > 0) {
  console.log("");
  console.log("Warnings:");
  for (const warning of warnings) {
    console.log(`  - ${warning}`);
  }
}

function syncCodex(target, targetPath) {
  const before = readText(targetPath) ?? "";
  const generated = buildCodexToml();
  const begin = "# BEGIN DOTFILES AGENTS MCP";
  const end = "# END DOTFILES AGENTS MCP";
  const block = `${begin}\n${generated.trimEnd()}\n${end}\n`;
  const after = replaceMarkedBlock(before, begin, end, block);

  writeChanged(target.name, targetPath, before, after);
}

function syncOpenCode(target, targetPath) {
  const before = readText(targetPath) ?? "{\n}\n";
  const root = parseJsoncObject(before, targetPath);
  const existingMcp = isObject(root.mcp) ? root.mcp : {};
  const mcp = {};

  for (const [name, server] of servers) {
    if (server.transport === "stdio") {
      mcp[name] = {
        type: "local",
        command: server.command,
        enabled: true
      };
      continue;
    }

    const existingServer = isObject(existingMcp[name]) ? existingMcp[name] : {};
    const { headers, missing } = materializedHeaders(server, existingServer, target.name, "headers");
    const entry = {
      type: "remote",
      url: server.url,
      enabled: missing.length === 0
    };

    if (Object.keys(headers).length > 0) {
      entry.headers = headers;
    }

    if (server.oauth !== undefined) {
      entry.oauth = server.oauth;
    }

    if (missing.length > 0) {
      warnings.add(`${target.name}: ${name} disabled until ${missing.join(", ")} is available`);
    }

    mcp[name] = entry;
  }

  const replacement = indentLines(`"mcp": ${JSON.stringify(mcp, null, 2)}`, "  ");
  const after = replaceTopLevelObjectProperty(before, "mcp", replacement);
  writeChanged(target.name, targetPath, before, after);
}

function syncMcpJson(target, targetPath) {
  const before = readText(targetPath) ?? "";
  const root = before.trim() ? parseJsoncObject(before, targetPath) : {};
  const top = isObject(root[target.topKey]) ? root[target.topKey] : {};
  const previousManaged = readManagedState(target.name);

  for (const name of new Set([...previousManaged, ...managedNames])) {
    delete top[name];
  }

  for (const [name, server] of servers) {
    const existingServer = existingServerFor(root[target.topKey], name);
    top[name] = buildMcpJsonServer(server, existingServer, target);
  }

  root[target.topKey] = top;
  const after = `${JSON.stringify(root, null, 2)}\n`;
  writeChanged(target.name, targetPath, before, after);
  writeManagedState(target.name, managedNames);
}

function buildMcpJsonServer(server, existingServer, target) {
  if (server.transport === "stdio") {
    const [command, ...args] = server.command;
    const entry = { command };

    if (target.style === "claude" || target.style === "copilot") {
      entry.type = "stdio";
    }

    if (args.length > 0) {
      entry.args = args;
    }

    return entry;
  }

  const { headers, missing } = materializedHeaders(server, existingServer, target.name, headerContainer(target));
  const entry = {};

  if (target.style === "claude") {
    entry.type = server.transport === "sse" ? "sse" : "http";
  } else if (server.transport === "sse") {
    entry.type = "sse";
  }

  entry.url = server.url;

  if (Object.keys(headers).length > 0) {
    if (target.style === "copilot") {
      entry.requestInit = { headers };
    } else {
      entry.headers = headers;
    }
  }

  if (missing.length > 0) {
    entry.disabled = true;
    warnings.add(`${target.name}: ${server.url} needs ${missing.join(", ")}`);
  }

  return entry;
}

function buildCodexToml() {
  let out = "";

  for (const [name, server] of servers) {
    const key = tomlKey(name);
    out += `[mcp_servers.${key}]\n`;

    if (server.transport === "stdio") {
      const [command, ...args] = server.command;
      out += `command = ${tomlString(command)}\n`;
      if (args.length > 0) {
        out += `args = ${tomlArray(args)}\n`;
      }
    } else {
      out += `url = ${tomlString(server.url)}\n`;

      if (server.transport === "sse") {
        out += `# Source registry transport is SSE; Codex stores remote servers by URL.\n`;
      }

      const codexHeaders = codexHeaderConfig(server);
      if (codexHeaders.bearerTokenEnvVar) {
        out += `bearer_token_env_var = ${tomlString(codexHeaders.bearerTokenEnvVar)}\n`;
      }

      if (Object.keys(codexHeaders.literalHeaders).length > 0) {
        out += `\n[mcp_servers.${key}.http_headers]\n`;
        for (const [header, value] of Object.entries(codexHeaders.literalHeaders)) {
          out += `${tomlKey(header)} = ${tomlString(value)}\n`;
        }
      }

      if (Object.keys(codexHeaders.envHeaders).length > 0) {
        out += `\n[mcp_servers.${key}.env_http_headers]\n`;
        for (const [header, envName] of Object.entries(codexHeaders.envHeaders)) {
          out += `${tomlKey(header)} = ${tomlString(envName)}\n`;
        }
      }
    }

    out += "\n";
  }

  return out;
}

function codexHeaderConfig(server) {
  const literalHeaders = {};
  const envHeaders = {};
  let bearerTokenEnvVar = null;

  for (const [header, spec] of Object.entries(server.headers ?? {})) {
    if (typeof spec === "string") {
      literalHeaders[header] = spec;
      continue;
    }

    if (!isObject(spec) || !spec.env) {
      continue;
    }

    if (
      header.toLowerCase() === "authorization" &&
      (spec.prefix ?? "") === "Bearer " &&
      !spec.suffix
    ) {
      bearerTokenEnvVar = spec.env;
    } else {
      envHeaders[header] = spec.env;
    }
  }

  return { bearerTokenEnvVar, envHeaders, literalHeaders };
}

function materializedHeaders(server, existingServer, targetName, container) {
  const headers = {};
  const missing = [];

  for (const [header, spec] of Object.entries(server.headers ?? {})) {
    if (typeof spec === "string") {
      headers[header] = spec;
      continue;
    }

    if (!isObject(spec) || !spec.env) {
      continue;
    }

    const envName = spec.env;
    const raw = lookupSecret(envName);
    const existing = existingHeader(existingServer, header, container);

    if (raw) {
      headers[header] = `${spec.prefix ?? ""}${raw}${spec.suffix ?? ""}`;
    } else if (existing) {
      headers[header] = existing;
    } else {
      headers[header] = `\${${envName}}`;
      missing.push(envName);
    }
  }

  return { headers, missing };
}

function existingHeader(existingServer, header, container) {
  if (!isObject(existingServer)) {
    return null;
  }

  if (container === "requestInit.headers") {
    return existingServer.requestInit?.headers?.[header] ?? null;
  }

  return existingServer.headers?.[header] ?? null;
}

function existingServerFor(top, name) {
  if (!isObject(top)) {
    return {};
  }

  return isObject(top[name]) ? top[name] : {};
}

function headerContainer(target) {
  return target.style === "copilot" ? "requestInit.headers" : "headers";
}

function loadSecrets() {
  const files = [
    process.env.AGENTS_SECRETS_FILE,
    path.join(home, ".config", "agents", "secrets.env"),
    path.join(agentsDir, "configs", "shared", "secrets.env")
  ].filter(Boolean);

  const loaded = {};

  for (const file of files) {
    if (!fs.existsSync(file)) {
      continue;
    }

    Object.assign(loaded, parseEnvFile(fs.readFileSync(file, "utf8")));
  }

  return loaded;
}

function lookupSecret(name) {
  return process.env[name] || secrets[name] || "";
}

function parseEnvFile(text) {
  const env = {};

  for (const rawLine of text.split(/\r?\n/)) {
    const line = rawLine.trim();
    if (!line || line.startsWith("#")) {
      continue;
    }

    const index = line.indexOf("=");
    if (index === -1) {
      continue;
    }

    const key = line.slice(0, index).trim();
    let value = line.slice(index + 1).trim();

    if (
      (value.startsWith('"') && value.endsWith('"')) ||
      (value.startsWith("'") && value.endsWith("'"))
    ) {
      value = value.slice(1, -1);
    }

    env[key] = value;
  }

  return env;
}

function parseJsoncObject(text, file) {
  try {
    const parsed = JSON.parse(removeTrailingCommas(stripJsonComments(text)));
    if (!isObject(parsed)) {
      throw new Error("top-level value is not an object");
    }
    return parsed;
  } catch (error) {
    throw new Error(`Failed to parse ${file}: ${error.message}`);
  }
}

function stripJsonComments(text) {
  let out = "";
  let inString = false;
  let escaped = false;
  let inLineComment = false;
  let inBlockComment = false;

  for (let i = 0; i < text.length; i += 1) {
    const char = text[i];
    const next = text[i + 1];

    if (inLineComment) {
      if (char === "\n") {
        inLineComment = false;
        out += char;
      }
      continue;
    }

    if (inBlockComment) {
      if (char === "*" && next === "/") {
        inBlockComment = false;
        i += 1;
      }
      continue;
    }

    if (inString) {
      out += char;
      if (escaped) {
        escaped = false;
      } else if (char === "\\") {
        escaped = true;
      } else if (char === '"') {
        inString = false;
      }
      continue;
    }

    if (char === '"') {
      inString = true;
      out += char;
    } else if (char === "/" && next === "/") {
      inLineComment = true;
      i += 1;
    } else if (char === "/" && next === "*") {
      inBlockComment = true;
      i += 1;
    } else {
      out += char;
    }
  }

  return out;
}

function removeTrailingCommas(text) {
  return text.replace(/,\s*([}\]])/g, "$1");
}

function replaceMarkedBlock(text, begin, end, block) {
  const start = text.indexOf(begin);
  if (start === -1) {
    if (text.length === 0) {
      return block;
    }

    const separator = text.endsWith("\n") || text.length === 0 ? "" : "\n";
    return `${text}${separator}\n${block}`;
  }

  const finish = text.indexOf(end, start);
  if (finish === -1) {
    throw new Error(`Found ${begin} without ${end}`);
  }

  let after = finish + end.length;
  if (text[after] === "\r" && text[after + 1] === "\n") {
    after += 2;
  } else if (text[after] === "\n") {
    after += 1;
  }

  return `${text.slice(0, start)}${block}${text.slice(after)}`;
}

function replaceTopLevelObjectProperty(text, property, replacement) {
  const range = findTopLevelObjectProperty(text, property);
  if (range) {
    const comma = range.hadTrailingComma ? "," : "";
    return `${text.slice(0, range.start)}${replacement}${comma}${text.slice(range.end)}`;
  }

  const close = text.lastIndexOf("}");
  if (close === -1) {
    return `{\n${replacement}\n}\n`;
  }

  const before = text.slice(0, close).trimEnd();
  const suffix = text.slice(close);
  const needsComma = !before.endsWith("{") && !before.endsWith(",");
  return `${before}${needsComma ? "," : ""}\n${replacement}\n${suffix}`;
}

function findTopLevelObjectProperty(text, property) {
  const needle = `"${property}"`;
  const propIndex = text.indexOf(needle);
  if (propIndex === -1) {
    return null;
  }

  const colon = text.indexOf(":", propIndex + needle.length);
  if (colon === -1) {
    return null;
  }

  const valueStart = nextNonWhitespace(text, colon + 1);
  if (text[valueStart] !== "{") {
    return null;
  }

  const valueEnd = findMatchingBrace(text, valueStart);
  let end = valueEnd + 1;
  const after = nextNonWhitespace(text, end);
  const hadTrailingComma = text[after] === ",";

  if (hadTrailingComma) {
    end = after + 1;
  }

  const lineStart = text.lastIndexOf("\n", propIndex) + 1;
  return { start: lineStart, end, hadTrailingComma };
}

function findMatchingBrace(text, start) {
  let depth = 0;
  let inString = false;
  let escaped = false;
  let inLineComment = false;
  let inBlockComment = false;

  for (let i = start; i < text.length; i += 1) {
    const char = text[i];
    const next = text[i + 1];

    if (inLineComment) {
      if (char === "\n") {
        inLineComment = false;
      }
      continue;
    }

    if (inBlockComment) {
      if (char === "*" && next === "/") {
        inBlockComment = false;
        i += 1;
      }
      continue;
    }

    if (inString) {
      if (escaped) {
        escaped = false;
      } else if (char === "\\") {
        escaped = true;
      } else if (char === '"') {
        inString = false;
      }
      continue;
    }

    if (char === '"') {
      inString = true;
    } else if (char === "/" && next === "/") {
      inLineComment = true;
      i += 1;
    } else if (char === "/" && next === "*") {
      inBlockComment = true;
      i += 1;
    } else if (char === "{") {
      depth += 1;
    } else if (char === "}") {
      depth -= 1;
      if (depth === 0) {
        return i;
      }
    }
  }

  throw new Error("Could not find matching closing brace");
}

function nextNonWhitespace(text, index) {
  let current = index;
  while (current < text.length && /\s/.test(text[current])) {
    current += 1;
  }
  return current;
}

function readManagedState(targetName) {
  const file = path.join(stateDir, `${targetName}.managed-mcp.json`);
  if (!fs.existsSync(file)) {
    return [];
  }

  try {
    const parsed = JSON.parse(fs.readFileSync(file, "utf8"));
    return Array.isArray(parsed.servers) ? parsed.servers : [];
  } catch {
    return [];
  }
}

function writeManagedState(targetName, names) {
  if (dryRun) {
    return;
  }

  fs.mkdirSync(stateDir, { recursive: true });
  const file = path.join(stateDir, `${targetName}.managed-mcp.json`);
  fs.writeFileSync(file, `${JSON.stringify({ servers: names }, null, 2)}\n`);
}

function writeChanged(targetName, targetPath, before, after) {
  if (before === after) {
    console.log(`  - ${targetName} unchanged`);
    return;
  }

  if (dryRun) {
    console.log(`  - ${targetName} would update ${displayPath(targetPath)}`);
    return;
  }

  fs.mkdirSync(path.dirname(targetPath), { recursive: true });
  fs.writeFileSync(targetPath, after);
  console.log(`  - ${targetName} updated ${displayPath(targetPath)}`);
}

function targetExists(target, targetPath) {
  if (target.presence) {
    return fs.existsSync(expandHome(target.presence)) || fs.existsSync(targetPath);
  }

  return fs.existsSync(targetPath) || fs.existsSync(path.dirname(targetPath));
}

function readText(file) {
  if (!fs.existsSync(file)) {
    return null;
  }

  return fs.readFileSync(file, "utf8");
}

function expandHome(value) {
  return value.replace(/^~(?=$|\/)/, home);
}

function displayPath(value) {
  return value.replace(home, "~");
}

function indentLines(text, indent) {
  return text
    .split("\n")
    .map((line) => `${indent}${line}`)
    .join("\n");
}

function tomlKey(value) {
  return /^[A-Za-z0-9_-]+$/.test(value) ? value : tomlString(value);
}

function tomlString(value) {
  return JSON.stringify(value);
}

function tomlArray(values) {
  return `[${values.map(tomlString).join(", ")}]`;
}

function isObject(value) {
  return value !== null && typeof value === "object" && !Array.isArray(value);
}
