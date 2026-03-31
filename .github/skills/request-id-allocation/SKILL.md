---
name: request-id-allocation
description: "Allocate or reuse docs/agent_docs request identifiers. Use when the leader or TAS must ignore request_0000, decide whether a follow-up belongs to the same active request, or assign the next active request number for materially new work."
argument-hint: "current user task and active request context"
user-invocable: true
---

# Request ID Allocation

Use this skill when the leader or TAS must decide whether to keep writing in an existing active request folder or start a new active request.

Do not use this skill for Beast Mode's own execution flow.

## Core Rules

- `request_0000` is reserved as the official template and example package.
- Never use `request_0000` for active work.
- Active request ids start at `request_0001`.
- Ignore `request_0000` when scanning for the next active request number.

## Reuse the Same Request When

- The user is asking for a small fix, missing piece, polish pass, or regression repair for the same primary outcome.
- The implementation target is materially the same and the work is a continuation rather than a new track.
- The artifact set for the current request still cleanly describes the work without forcing a new planning context.

## Allocate a New Request When

- The request category changes.
- The primary deliverable changes.
- The target subsystem or major file set changes materially.
- The work would require a fresh research or planning context rather than a small extension of the previous one.

## Allocation Procedure

1. Inspect docs/agent_docs/.
2. Treat `request_0000` as reserved and exclude it from active numbering.
3. Identify the latest active request id.
4. Compare the user's new message with the current active request scope.
5. Reuse the active request if the work is a small continuation.
6. Otherwise allocate the next active request id using four-digit zero padding.
7. State the chosen request id explicitly before writing or updating artifacts.

## Validation Checklist

- Did you ignore `request_0000`?
- Did you explicitly decide reuse versus new allocation?
- If you reused a request, did you explain why the work is the same category?
- If you created a new request, did you explain what changed materially?

## Output Template

Use [assets/request-id-decision.template.md](./assets/request-id-decision.template.md) when you need a compact decision record.