---
name: rust-review
description: >-
  Review Rust code for correctness, safety, idioms, and performance — run
  clippy/fmt, audit unsafe and unwrap, check ownership/borrowing and error
  handling, spot async pitfalls, and confirm tests. Use when reviewing or
  hardening Rust before merge, or when asked to make Rust more idiomatic. Runs
  the toolchain first, then reads for what tools can't catch.
allowed-tools: Read Bash Edit
---

# Rust Review

Let the toolchain do the mechanical pass first, then read for the things it
can't see. Don't hand-review what `clippy` already flags.

## 1. Run the toolchain

```bash
cargo fmt --check                 # formatting
cargo clippy --all-targets --all-features -- -D warnings   # lints as errors
cargo test                        # tests pass
cargo build --release 2>&1 | tail # warnings
```

If `cargo-audit` / `cargo-deny` are installed, run them for advisories:
`cargo audit`. Fix or justify every clippy finding — don't `#[allow]` silently.

## 2. Read for what clippy misses

**Unsafe.** Every `unsafe` block needs a comment stating the invariant that
makes it sound, and a reason a safe alternative won't do. Unjustified `unsafe` is
the highest-priority finding.

**Panics in library code.** `unwrap()` / `expect()` / `panic!` / indexing
`v[i]` / integer division — fine in tests and `main`, suspect in library paths.
Prefer `?`, `ok_or`, `get`, `checked_*`. Flag each one: can this input make it
panic?

**Error handling.** Libraries: typed errors (`thiserror`). Applications:
`anyhow`/`eyre` with context (`.with_context(...)`). Errors should say what
failed and why. No `Result<_, String>` in real code.

**Ownership & borrowing.** Needless `.clone()` to dodge the borrow checker;
`String` where `&str` would do; `Vec<T>` args where `&[T]` works; returning owned
data that could be borrowed. APIs should take the least-owning type that works.

**Idioms.** Iterator chains over manual index loops; `if let` / `let else` /
`matches!` over verbose matches; `impl Trait` where it reads cleaner; derive
(`Debug, Clone, PartialEq`) rather than hand-writing; `From`/`TryFrom` for
conversions. Newtypes over bare primitives for domain types.

**Async (tokio).** No blocking calls (`std::fs`, `std::thread::sleep`, heavy CPU)
inside async tasks — use the async equivalents or `spawn_blocking`. Watch for
holding a `std`/`parking_lot` lock across `.await` (deadlock risk); don't
`.await` while holding a `Mutex` guard. Check that spawned tasks are awaited or
intentionally detached, and that cancellation is handled.

**Concurrency.** `Arc<Mutex<…>>` that could be a channel or `RwLock`; data shared
without `Send`/`Sync` thought-through.

## 3. Tests

- Meaningful coverage of behavior and failure paths, not just the happy path.
- `#[should_panic]` / `Result`-returning tests where apt.
- Property tests (`proptest`) for parsers/encoders.
- Doc examples (`cargo test --doc`) compile and run.

## Severity

- **Blocker:** unjustified `unsafe`, a reachable panic on user input, a
  `.await`-across-lock deadlock, UB.
- **Important:** missing error context, needless clones in hot paths, blocking in
  async, missing tests on a failure path.
- **Minor:** non-idiomatic but correct; naming; style clippy didn't catch.

Report findings as `file:line` + the concrete fix. Only flag what's worth the
author's time.
