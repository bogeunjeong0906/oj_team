---
name: tas-action-mode
description: "Run the TAS action stage by implementing plan.md, validating changes, performing self-review, and writing report.md."
argument-hint: "active request and implementation scope"
user-invocable: true
---

# TAS Action Mode

Use this skill only when TAS is locked to action mode.

## Core Rules

- Read plan.md first.
- Implement only the planned scope and directly adjacent files needed to finish it.
- Run relevant validation and inspect Problems before leaving the mode.
- Record implementation outcome and self-review in report.md.

## Required Output

- Implemented scope
- Files changed
- Validation performed
- Deviations from the plan
- Self-review summary
- Remaining issues or residual risks

## Rollback Rules

- Return to plan mode when implementation direction changes materially.
- Return to research mode only when a missing fact blocks a stable implementation.

## Mode Exit Rule

- Do not leave action mode until code changes, validation, self-review, and report.md update are complete for the current scope.