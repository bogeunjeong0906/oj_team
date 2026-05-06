---
name: complexity-gate
description: "Prefer simpler active control paths over additive implementations. Require explicit justification when helpers, branches, shims, or duplicate paths increase structural complexity. Use during planning, execution, and self-review."
argument-hint: "changed control path, helper addition, or suspected complexity growth"
user-invocable: true
---

# Complexity Gate

Use this skill whenever a change risks making the repository harder to reason about.

## Goals

- Bias the agent toward smaller active path count.
- Prevent incremental edits from turning into layered, hard-to-debug structures.
- Make complexity increases rare, visible, and justified.

## Default Rule

- Prefer modifying the controlling path over adding a parallel path.
- Prefer deleting a superseded branch over keeping both branches active.
- Prefer one well-named helper over several transitional helpers with overlapping roles.

## Requires Justification

- adding a new helper
- adding a new branch in an already complex control path
- adding a shim, adapter, wrapper, or compatibility mode
- keeping both old and new paths active

## Review Questions

- Did the change reduce, preserve, or increase active path count?
- Did the change remove duplicated logic?
- Did the change leave behind any branch that now exists only for caution rather than a real requirement?
- Could the same result have been achieved by tightening an existing path instead?

## Smells

- one-off option flags
- compatibility layers with no owner or expiry condition
- wrappers that only forward to one implementation
- duplicate condition trees for nearly identical behavior

## Output Template

Use [assets/complexity-review.template.md](./assets/complexity-review.template.md) when recording the self-review result.