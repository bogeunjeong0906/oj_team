---
name: tas-plan-mode
description: "Run the TAS planning stage and write plan.md from research.md without editing product code."
argument-hint: "active request and planning scope"
user-invocable: true
---

# TAS Plan Mode

Use this skill only when TAS is locked to plan mode.

## Core Rules

- Read research.md first.
- Do not edit product code.
- Convert research output into a concrete, ordered execution plan.
- Write or update plan.md before leaving the mode.

## Required Output

- Scope and assumptions
- Ordered steps
- Target files
- Validation plan
- Completion criteria
- Rollback triggers for returning to research

## Mode Exit Rule

- Do not leave plan mode until plan.md is specific enough that action mode can implement without reopening broad exploration.