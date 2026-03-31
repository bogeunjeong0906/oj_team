---
name: Agent Artifacts
description: "Use when creating or updating docs/agent_docs request artifacts such as research.md, researchN.md, plan.md, report.md, and review.md for the orchestration or TAS workflows."
applyTo: "docs/agent_docs/**/*.md"
---

# Agent Artifact Conventions

- These conventions apply to the internal Leader workflow and TAS standalone workflow, not to Beast Mode standalone execution.

- Store all request artifacts under docs/agent_docs/request_XXXX/.
- Treat docs/agent_docs/request_0000/ as the official template and example package.
- Do not write active work into docs/agent_docs/request_0000/.
- Use these canonical file names: research.md, research1.md, research2.md, plan.md, report.md, review.md.
- TAS normally uses research.md, plan.md, and report.md. review.md remains optional outside the default TAS flow.

- Keep each artifact focused on one stage of the workflow.
- Prefer concise sections and explicit headings over long narrative prose.

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
- Self-review summary when TAS action mode is used

## review.md

- Findings
- Evidence and impacted files
- Tests or checks considered
- Open questions
- Residual risk or approval status