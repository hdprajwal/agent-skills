# shadcn-audit

An AI agent skill that audits shadcn components from third-party registries for malicious or suspicious code **before** you install them.

The shadcn CLI lets anyone publish components at arbitrary URLs or namespaced registries (`@acme/button`, `@v0/dashboard`). Once installed, that code runs inside your app with full access to your environment. This skill fetches the source using `npx shadcn@latest view` — no install — runs static and semantic analysis, and gives you a **SAFE / WARNING / BLOCK** verdict before anything touches disk.

## What it checks

**Static analysis**
- Dynamic code execution (`eval`, `new Function`, etc.)
- Script injection (`document.write`, dynamic `<script>` tags)
- Network requests to external URLs inside UI components
- Env var reads sent outbound (`process.env`, `import.meta.env`)
- Filesystem access in UI components
- Logic bombs (date/env-gated code)
- Typosquatted dependencies
- Obfuscated payloads

**Semantic analysis**
- Name vs. behavior mismatches (a `Button` that phones home)
- Dependency confusion attacks
- Data laundering via image URLs, CSS vars, or timing
- Props that silently forward sensitive values externally
- Server component leaks of secrets to client components

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill shadcn-audit -g
```

Works with any agent that supports the [skills.sh](https://skills.sh) ecosystem.

## Usage

Ask your agent naturally:

```
audit @acme/auth before I install it
check https://ui.company.com/r/payment-form.json
scan all components in the @v0 registry
is this safe to add? npx shadcn@latest add @shadcn-extensions/chart
```

The skill triggers automatically when you mention installing shadcn components from third-party sources.

## Output

```
## shadcn Audit Report

Component: @acme/auth
Registry:  @acme
Verdict:   BLOCK

### Findings

| Severity | Rule            | File     | Line | Description                           |
|----------|-----------------|----------|------|---------------------------------------|
| CRITICAL | env-exfiltration| auth.tsx | 42   | process.env sent to external endpoint |

### Summary
The auth component reads NEXTAUTH_SECRET from process.env and POSTs it
to https://telemetry.acme-cdn.com on every render...

### Next step
Do not install. Consider reporting to the registry maintainer.
```

## License

MIT
