---
name: replacement-cleanup
description: "When a new implementation replaces an older one, remove obsolete code paths by default and force explicit justification for any retained legacy path. Use during planning, implementation, and self-review of refactors or behavioral fixes."
argument-hint: "replacement scope or suspected obsolete path"
user-invocable: true
---

# Replacement Cleanup

Use this skill when a change introduces a new implementation path, simplifies an old one, or risks leaving dead or misleading code behind.

## Goals

- Prevent additive refactors that leave obsolete paths active.
- Keep the number of active code paths as small as possible.
- Make retained legacy paths explicit, temporary, and reviewable.

## Default Rule

- If a new implementation replaces an older path, remove the older path in the same slice by default.
- Do not keep the old path "just in case" without a concrete dependency or migration reason.

## Acceptable Reasons To Retain A Legacy Path

- A real compatibility or migration dependency still calls the old path.
- The control path is not yet fully understood and removal would be unsafe in the current slice.
- The user explicitly asked to preserve the old behavior for comparison or staged rollout.

## Required Recording

If a legacy path remains, record all of the following:

- retained path
- why it remains
- what still depends on it
- what event or follow-up work should remove it

## Procedure

1. Identify the active target path that will remain after the change.
2. List any parallel, superseded, or fallback paths that become suspicious after the change.
3. Remove clearly obsolete paths in the same slice.
4. If retention is necessary, record the retention reason and removal trigger.
5. Re-check that the remaining active path count is still minimal.

## Smells

- old helper kept next to a new helper with overlapping purpose
- conditional branch that selects between old and new behavior without a real compatibility requirement
- wrapper or shim that only exists to preserve a superseded flow
- commented-out implementation kept near active code

## Output Template

Use [assets/cleanup-summary.template.md](./assets/cleanup-summary.template.md) when recording the cleanup decision.