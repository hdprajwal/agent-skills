# mcp-builder

Build, scaffold, and review MCP servers that give LLMs well-designed tools.

Covers research-first design (read the spec, not memory), stack choice (TypeScript MCP SDK / Python FastMCP), transports (stdio local / streamable HTTP remote), the tool-design decisions where quality actually lives (naming, descriptions, input schemas, focused/paginated outputs, recoverable errors), minimal TS + Python templates, and evaluating the server the way an agent would use it.

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill mcp-builder -g
```

## Requires

Node + `@modelcontextprotocol/sdk` (TS) or `pip install mcp` (Python FastMCP).
