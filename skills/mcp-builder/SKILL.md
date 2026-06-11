---
name: mcp-builder
description: Build, scaffold, and review MCP (Model Context Protocol) servers that give LLMs well-designed tools over an external API or service. Use when creating or improving an MCP server in TypeScript (MCP SDK) or Python (FastMCP) — tool design, transports (stdio local / streamable HTTP remote), error shapes, and evaluation. Grounds tool design in the official spec.
allowed-tools: Read Write Edit Bash WebFetch
---

# MCP Builder

An MCP server is judged by one thing: **how well it lets an agent actually get
real tasks done.** Design for the calling LLM, not for API completeness.

## 1. Research first

- **Read the spec, don't guess.** Start at `https://modelcontextprotocol.io/sitemap.xml`,
  fetch pages with a `.md` suffix for markdown (e.g.
  `.../specification/draft.md`). Review architecture, transports, and
  tool/resource/prompt definitions — the protocol moves, so check current.
- **Understand the target API** you're wrapping: auth, endpoints, rate limits,
  pagination, error formats.

## 2. Choose the stack

- **TypeScript + `@modelcontextprotocol/sdk`** — default. Strong SDK, good
  compatibility, models write it well. `pnpm add @modelcontextprotocol/sdk zod`.
- **Python + FastMCP** — when the surrounding code is Python (research/ML).
  `pip install mcp` (FastMCP is included).
- **Transport:** `stdio` for local servers (the common case — runs as a
  subprocess of the client). **Streamable HTTP** for remote servers; prefer
  stateless JSON (simpler to scale than stateful sessions/streaming).

## 3. Design the tools (this is where quality lives)

- **Coverage vs. workflow tools.** Comprehensive endpoint coverage gives agents
  flexibility to compose; workflow tools bundle a common multi-step task. When
  unsure, lean to coverage. Add a workflow tool when one task takes many calls.
- **Names:** action-oriented, consistently prefixed — `github_create_issue`,
  `github_list_repos`. The agent finds the right tool by its name.
- **Descriptions:** concise, say what it does and when to use it. This is the
  agent's only guide — invest here.
- **Inputs:** validate with a schema (`zod` in TS, type hints/Pydantic in
  Python). Mark required vs optional; give defaults.
- **Outputs:** return focused, relevant data. Support pagination/filtering so a
  call can't dump 10k rows into the context window.
- **Errors are instructions.** A failed call should tell the agent how to
  recover: what was wrong, what to try next — not a raw stack trace.

## 4. Minimal shape

TypeScript (stdio):

```ts
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js"
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js"
import { z } from "zod"

const server = new McpServer({ name: "my-service", version: "0.1.0" })

server.tool(
  "myservice_search",
  "Search items by query. Returns up to `limit` matches with id + title.",
  { query: z.string(), limit: z.number().int().max(50).default(10) },
  async ({ query, limit }) => {
    try {
      const results = await api.search(query, limit)
      return { content: [{ type: "text", text: JSON.stringify(results) }] }
    } catch (e) {
      return { content: [{ type: "text", text: `Search failed: ${e.message}. Check the query is non-empty and the API token is set.` }], isError: true }
    }
  }
)
await server.connect(new StdioServerTransport())
```

Python (FastMCP):

```python
from mcp.server.fastmcp import FastMCP
mcp = FastMCP("my-service")

@mcp.tool()
def myservice_search(query: str, limit: int = 10) -> str:
    """Search items by query. Returns up to `limit` matches."""
    ...

if __name__ == "__main__":
    mcp.run()   # stdio by default
```

## 5. Test it like an agent would

- Run locally and inspect with the **MCP Inspector**:
  `npx @modelcontextprotocol/inspector node build/index.js`.
- Write an **evaluation**: a handful of realistic tasks, then check whether an
  agent can complete each using only the tools + descriptions. Fix the tools the
  agent misuses or can't find — that's the real bug, not the code.
- Add it to a client config (Claude Code / claude.ai / Cursor) and dry-run the
  top tasks.

## Review checklist (for an existing server)

- [ ] Tool names consistent, prefixed, action-oriented
- [ ] Every description says what + when, concisely
- [ ] Inputs schema-validated; outputs focused + paginated
- [ ] Errors guide recovery
- [ ] Right transport (stdio local / streamable HTTP remote, stateless)
- [ ] Secrets from env, never hardcoded
- [ ] An eval proves an agent can do the real tasks

## Credit

Tool-design guidance adapted from the `mcp-builder` skill in
[anthropics/skills](https://github.com/anthropics/skills). Spec is authoritative:
https://modelcontextprotocol.io.
