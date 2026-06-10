# rust-review

Review Rust for correctness, safety, idioms, and performance.

Runs the toolchain first (`fmt`, `clippy -D warnings`, `test`, `audit`), then reads for what tools miss: unjustified `unsafe`, reachable panics (`unwrap`/indexing) in library code, error-handling (thiserror/anyhow + context), needless clones and over-owning APIs, non-idiomatic patterns, and async/tokio pitfalls (blocking in async, locks held across `.await`). Findings are severity-tagged with concrete fixes.

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill rust-review -g
```

## Requires

A Rust toolchain (`cargo`, `clippy`, `rustfmt`); optionally `cargo-audit`.
