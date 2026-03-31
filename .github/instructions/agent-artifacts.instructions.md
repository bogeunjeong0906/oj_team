---
name: Agent Artifacts
description: "Use when creating or updating docs/agent_docs request artifacts such as researchN.md, plan.md, report.md, and review.md for the orchestration workflow."
applyTo: "docs/agent_docs/**/*.md"
---

# Agent Artifact Conventions

- These conventions apply to the internal Leader workflow, not to Beast Mode standalone execution.

- Store all request artifacts under docs/agent_docs/request_XXXX/.
- Treat docs/agent_docs/request_0000/ as the official template and example package.
- Do not write active work into docs/agent_docs/request_0000/.
 Use these canonical file names: research.md, research1.md, research2.md, plan.md, report.md, review.md.

## researchN.md

## research.md (Main Researcher)

- Summary
- Scope investigated
- Codebase facts
- External or domain facts
- Constraints for implementation
- Risks and open questions

## researchN.md (Subresearcher N)

- Summary
- Scope investigated
- Codebase facts
- External or domain facts
- Constraints for implementation
- Risks and open questions

## plan.md

- Scope and assumptions
- Ordered steps
- Target files
- Validation plan
- Completion criteria
- Risks and decision points

## report.md

- Implemented scope
- Files changed
- Validation performed
- Deviations from the plan
- Remaining issues

## review.md

- Findings
- Evidence and impacted files
- Tests or checks considered
- Open questions
- Residual risk or approval status