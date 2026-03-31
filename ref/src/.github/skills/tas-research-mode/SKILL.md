---
name: tas-research-mode
description: "Run the TAS research stage and write research.md without editing product code."
argument-hint: "active request and research scope"
user-invocable: true
---

# TAS Research Mode

Use this skill only when TAS is locked to research mode.

## Core Rules

- Do not edit product code.
- Investigate only the files and references needed to bound implementation.
- Write or update research.md before leaving the mode.
- Distinguish facts, assumptions, constraints, and open questions.

## Required Output

- Summary
- Scope investigated
- Relevant codebase facts
- External or domain facts when needed
- Constraints for implementation
- Risks and open questions
- Recommended implementation boundaries
- Evidence that research is sufficient for planning

## Mode Exit Rule

- Do not leave research mode until research.md gives plan mode enough information to build ordered steps and validation.