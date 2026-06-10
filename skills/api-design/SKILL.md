---
name: api-design
description: >-
  Design stable, well-shaped interfaces before implementing them — HTTP/REST
  endpoints, MCP tools, or library/module APIs. Use when adding a public
  endpoint, defining a contract between modules, designing MCP tools, or shaping
  a library's surface. Focuses on naming, contracts, error shapes, versioning,
  and backward compatibility — the parts that are expensive to change later.
allowed-tools: Read Write Edit
---

# API Design

The contract is the expensive part — implementations change cheaply, public
surfaces don't. Design the interface first, write it down, then build to it.

## Design the contract first

Before code, specify for each operation: inputs (types, required vs optional,
defaults, validation), outputs (shape, success), errors (what can fail and how
it's reported), and side effects. Make it explicit — types, a schema, an OpenAPI
snippet, or a typed signature — so callers can build against it before the
implementation exists (contract-first lets front/back or client/server proceed
in parallel).

## Naming & consistency

- One vocabulary across the whole surface. Same concept → same word everywhere.
- Action-oriented and predictable. REST: nouns + HTTP verbs
  (`GET /users/{id}`, `POST /users`). MCP tools: prefixed verbs
  (`github_create_issue`). Library: verbs that match the language's conventions.
- Symmetry: if there's a `create`, the `get`/`list`/`update`/`delete` should look
  like siblings, not strangers.

## Error shapes

- Consistent, machine-readable: a stable code + a human message + (where useful)
  which field and how to fix it. Don't leak stack traces.
- HTTP: correct status codes (4xx caller's fault, 5xx yours) + a structured body.
- MCP/library: typed errors that tell the caller how to recover.
- Decide and document what happens on partial failure.

## Shape for real use

- **Pagination/limits** on anything list-like — never let one call return
  unbounded data.
- **Idempotency** for writes that may be retried (idempotency keys, or
  `PUT` semantics).
- **Least surface that works** — fewer, composable operations beat dozens of
  one-off endpoints. You can add later; you can't quietly remove.
- Sensible **defaults** so the common call is short; options for the rest.

## Versioning & compatibility

- Additive changes (new optional field, new endpoint) are safe. Removing or
  renaming a field, tightening validation, or changing a type is breaking.
- Version when you must break (`/v2`, or a version field). Deprecate with a
  migration path and a timeline, don't yank.
- Treat the response shape as a promise — clients depend on fields you think are
  internal.

## Review checklist

- [ ] Contract written down before implementation
- [ ] Naming consistent and predictable across the surface
- [ ] Errors structured, coded, recoverable
- [ ] Lists paginated/bounded; writes idempotent where retried
- [ ] Defaults make the common case easy
- [ ] Changes classified additive vs breaking; breaking → versioned + migration
- [ ] Documented with at least one example request/response per operation

For MCP tool surfaces specifically, pair with the **mcp-builder** skill.
