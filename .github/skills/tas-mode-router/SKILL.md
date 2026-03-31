---
name: tas-mode-router
description: "Choose the active TAS request and mode, then enforce serial transitions across research, plan, and action without subagent delegation."
argument-hint: "user task, active request state, and desired stage"
user-invocable: true
---

# TAS Mode Router

Use this skill when TAS must decide which request folder is active and which mode is allowed to run next.

## Core Rules

- TAS uses request artifacts for its own work.
- TAS must process modes in serial order: research, then plan, then action.
- TAS may finish multiple modes in one turn, but only by completing them one at a time in order.
- TAS must not mix unfinished work from multiple modes concurrently.

## Request Decision Order

1. Read docs/agent_docs/ and ignore request_0000.
2. Reuse the current active request when the new work is a small continuation of the same primary outcome.
3. Allocate a new request when the primary deliverable, major target area, or implementation direction changes materially.

## Mode Decision Order

1. If the user explicitly requests only one stage, lock to that mode unless a required earlier artifact is missing.
2. If no explicit stage is given, inspect the active request state.
3. If research.md is missing or stale, use research mode.
4. Else if plan.md is missing or stale, use plan mode.
5. Else use action mode.

## Rollback Rules

- Roll back from action to plan when the implementation direction changes materially.
- Roll back from plan or action to research only when a missing fact materially blocks a stable implementation.
- When rolling back, update the earlier artifact before returning to the later mode.

## Completion Gate

- Do not leave a mode until its artifact is updated with a usable completion state.
- research mode exits only after research.md is sufficient to bound planning.
- plan mode exits only after plan.md is sufficient to guide implementation and validation.
- action mode exits only after implementation, validation, self-review, and report.md update are complete for the current scope.

## Output Template

- Active request id
- Mode lock: research, plan, or action
- Trigger for this mode choice
- Whether a later mode may run in the same turn