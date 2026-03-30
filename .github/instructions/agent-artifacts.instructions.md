---
name: Agent Artifacts
description: "Use when creating or updating docs/agent_docs request artifacts such as researchN.md, plan.md, report.md, and review.md for the orchestration workflow."
applyTo: "docs/agent_docs/**/*.md"
---

# Agent Artifact Conventions

- Store all request artifacts under docs/agent_docs/request_XXXX/.
- Use these canonical file names: research1.md, research2.md, plan.md, report.md, review.md.
- Keep each artifact focused on one stage of the workflow.
- Prefer concise sections and explicit headings over long narrative prose.

## researchN.md

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