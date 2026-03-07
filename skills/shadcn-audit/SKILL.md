---
name: shadcn-audit
description: Security auditor for shadcn components from third-party registries. Use this skill whenever the user mentions installing, adding, or using a shadcn component from a third-party source — even if they just say "add @acme/button" or paste a shadcn registry URL. Trigger it proactively when you see `npx shadcn add`, a namespaced component like `@v0/...` or `@acme/...`, or any URL ending in `.json` that looks like a registry item. The skill fetches source with `npx shadcn@latest view` (no install), runs static analysis and semantic checks, and produces a SAFE / WARNING / BLOCK verdict before anything touches disk.
license: MIT
metadata:
  author: hdprajwal
  version: "1.0.0"
allowed-tools: Bash
---

# shadcn Component Security Auditor

## Overview

The shadcn CLI lets anyone publish components at arbitrary URLs or namespaced registries (`@acme/button`, `@v0/dashboard`). Unlike npm packages, shadcn copies source code directly into your project — meaning it runs with full access to your environment and no sandbox. This skill intercepts that process: it fetches the component source using the shadcn CLI's `view` command (nothing is installed), audits the code for malicious or suspicious patterns, and gives a verdict before anything touches disk.

## Table of Contents

- [When to Use](#when-to-use)
- [Instructions](#instructions)
- [Step 1 — Fetch the Source](#step-1--fetch-the-source)
- [Step 2 — Static Analysis](#step-2--static-analysis)
- [Step 3 — Semantic Analysis](#step-3--semantic-analysis)
- [Step 4 — Report](#step-4--report)
- [Verdict Rules](#verdict-rules)
- [Examples](#examples)
- [Constraints and Warnings](#constraints-and-warnings)

## When to Use

- User wants to install a shadcn component from a third-party registry (`@acme/...`, `@v0/...`, etc.)
- User pastes a registry URL ending in `.json`
- User runs or plans to run `npx shadcn@latest add <anything>`
- User asks "is this safe to install?" about a shadcn component
- User wants to audit an entire third-party registry before using it

## Instructions

1. **Fetch** the component source using `npx shadcn@latest view` — do not install
2. **Run static analysis** against the defined checklist of patterns
3. **Run semantic analysis** to catch intent mismatches the static rules miss
4. **Produce a structured report** with a SAFE / WARNING / BLOCK verdict
5. **Give a clear next step** — either the install command or a reason not to proceed

---

## Step 1 — Fetch the Source

```bash
npx shadcn@latest view <component>
```

For a whole registry, list items first then view each:

```bash
npx shadcn@latest search <@registry>
npx shadcn@latest view <@registry/item>
```

Also run a dry-run to see every file that would be written to disk:

```bash
npx shadcn@latest add --dry-run <component>
```

If either command fails or returns nothing, tell the user the component could not be fetched and stop — do not proceed without source.

---

## Step 2 — Static Analysis

Check every file in the output against these patterns. A single CRITICAL finding is enough to block.

### CRITICAL
| Pattern | Why it matters |
|---------|----------------|
| `eval(`, `new Function(`, `setTimeout(string)` | Dynamic code execution — runs arbitrary code |
| Hex/base64 blobs that decode to executable code | Obfuscation — hides malicious payload |
| `document.write(` or dynamic `<script>` tag construction | Script injection |
| `fetch`/`XMLHttpRequest`/`WebSocket` to hardcoded external URLs inside UI components | Data exfiltration |
| Reading `process.env` or `import.meta.env` and sending the value outbound | Env var theft |

### HIGH
| Pattern | Why it matters |
|---------|----------------|
| `dangerouslySetInnerHTML` with a non-literal value | XSS risk |
| `fs.readFile`, `fs.writeFile`, `fs.unlink` in a UI component | Filesystem access where it shouldn't be |
| `import(variable)` — computed dynamic import path | Can load arbitrary code at runtime |
| Code gated on specific dates, times, or env values | Logic bomb |
| Dependencies not on npm or likely typosquats (`lodahs`, `reacct`) | Supply chain |

### MEDIUM
| Pattern | Why it matters |
|---------|----------------|
| `dangerouslySetInnerHTML` with a literal string | Inspect the string itself |
| Fetch URL constructed from unsanitized user input | Potential SSRF or open redirect |
| `localStorage`/`sessionStorage` reads followed by network calls | Data leakage |
| `crypto.subtle` in a pure UI component | Unusual — flag for review |
| Re-exporting base components with modified prop handling | Could intercept sensitive values |

### LOW
| Pattern | Why it matters |
|---------|----------------|
| Heavily minified or obfuscated variable names | Obscures intent |
| Commented-out suspicious code | Worth noting |
| `console.log` printing suspiciously named variables | Accidental or intentional leakage |
| `window.location`, `document.referrer`, `navigator.userAgent` sent externally | Tracking |

---

## Step 3 — Semantic Analysis

Static pattern matching won't catch everything. After the checklist, reason about the component holistically:

- **Name vs. behavior mismatch** — A `Button` that makes network requests, an `Avatar` that reads env vars. Anything doing more than its name implies.
- **Dependency confusion** — Imports a package that shadows a well-known one (a custom `react-dom`, a `tailwindcss` fork).
- **Data laundering** — Encoding data into image request URLs, CSS custom properties, or artificial timing delays before sending it.
- **Social engineering via props** — Props like `onReady`, `apiKey`, `token` that silently forward user-provided values to an external endpoint.
- **Server component leaks** — A server component passing `process.env` or a full config object as props to a client component.

---

## Step 4 — Report

Always produce a report in this exact structure:

```
## shadcn Audit Report

Component: <name or URL>
Registry:  <registry or "direct URL">
Verdict:   SAFE | WARNING | BLOCK

### Findings

| Severity | Rule | File | Line | Description |
|----------|------|------|------|-------------|
| ...      | ...  | ...  | ...  | ...         |

(No findings → write "No issues found.")

### Summary
One paragraph. BLOCK: explain exactly what is dangerous and how.
WARNING: explain what is suspicious and what the user should manually verify.
SAFE: briefly confirm what was checked and why it passes.

### Next step
SAFE:    `npx shadcn@latest add <component>`
WARNING: Review the flagged lines, then decide.
BLOCK:   Do not install. Consider reporting to the registry maintainer.
```

---

## Verdict Rules

| Verdict | Condition |
|---------|-----------|
| BLOCK   | Any CRITICAL finding, or 2+ HIGH findings |
| WARNING | Any HIGH finding, or 3+ MEDIUM findings |
| SAFE    | No findings, or only LOW/MEDIUM with clear benign explanations |

---

## Examples

### SAFE — Official component

```
## shadcn Audit Report

Component: button
Registry:  https://ui.shadcn.com (official)
Verdict:   SAFE

### Findings

No issues found.

### Summary
The button component is a 64-line React wrapper around Radix UI's Slot
primitive with CVA for variant management. It makes no network calls,
reads no environment variables, and its two dependencies (radix-ui,
class-variance-authority) are well-established packages.

### Next step
`npx shadcn@latest add button`
```

### BLOCK — Malicious third-party component

```
## shadcn Audit Report

Component: @acme/auth
Registry:  @acme
Verdict:   BLOCK

### Findings

| Severity | Rule             | File     | Line | Description                                    |
|----------|------------------|----------|------|------------------------------------------------|
| CRITICAL | env-exfiltration | auth.tsx | 42   | process.env.NEXTAUTH_SECRET sent to remote URL |

### Summary
The component reads NEXTAUTH_SECRET from process.env and POSTs it to
https://telemetry.acme-cdn.com on every render. This is a credential
theft attack disguised as telemetry.

### Next step
Do not install. Consider reporting to the registry maintainer.
```

---

## Constraints and Warnings

- **Always fetch source first.** Never give a verdict based on the component name alone — `npx shadcn@latest view` must succeed before any analysis.
- **The dry-run may fail** if the working directory has no `package.json`. That's fine — the `view` output is sufficient for a full audit.
- **Check transitive local files.** If a component imports a local utility (`../lib/utils`), view that file too before concluding.
- **Official `@shadcn` registry is lower risk** but still run all checks — only reserve BLOCK for clear evidence even on official components.
- **For a full registry scan**, show a summary table (one row per component, verdict column) at the top, then detailed findings for any non-SAFE items below.
