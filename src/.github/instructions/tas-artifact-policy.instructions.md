---
name: TAS Artifact Policy
description: "Use when TAS creates, updates, or reuses request artifacts for analysis, plan, and execution work while preserving prior context."
applyTo: ".github/agent_docs/**/*.md"
---

# TAS Artifact Policy

These rules apply to TAS request artifacts only.

- Use request artifacts for non-trivial TAS work.
- Store active work under `.github/agent_docs/request_XXXX/`.
- Treat `.github/agent_docs/request_0000/` as the template package and never as active work.
- TAS uses exactly four canonical artifacts: `prompt.md`, `research.md`, `plan.md`, and `report.md`.
- Keep `prompt.md` synchronized with the current user requirements before later-stage artifacts are updated.
- Artifact preservation rules do not justify preserving obsolete implementation paths in code.
- Default stage order is analysis, then plan, then execution.
- Do not skip directly from analysis to execution.
- Read `prompt.md` before analysis, plan, or execution work when the request is non-trivial.
- Read `research.md` before plan work.
- Read both `research.md` and `plan.md` before execution work.
- Write artifact prose in the user's request language unless the user explicitly asks for another language.
- Keep code, commands, file names, APIs, and quoted external text in their original language when translation would reduce precision.

## Request Reuse

- Reuse the current request when the user is continuing the same primary outcome.
- Create a new request only when the primary deliverable, target area, or implementation direction changes materially.
- Ignore `request_0000` when choosing the next active request id.

## Turn Boundary

- By default, finish one stage and stop for user direction.
- If the user explicitly asks for chained work, continue sequentially in the same turn without skipping stages.

## Preservation Rules

- Do not replace an existing artifact with a fresh rewrite unless the user explicitly asks for a reset.
- Preserve prior findings, assumptions, decisions, risks, and history when updating an artifact.
- If earlier content is no longer valid, mark it as `Superseded` or `Revised` instead of deleting it silently.
- When the user asks for follow-up research on only one subtopic, keep the rest of the existing research intact.
- When the plan changes, append or revise the relevant section without erasing prior decisions.
- When execution discovers a deviation, record it in `report.md` instead of rewriting earlier artifacts to hide the change.
- If the user switches languages mid-request, preserve prior content and write new or revised prose in the latest user-request language unless the user asks for a full translation pass.

## Stage Expectations

### prompt.md

- Summarizes the user's requirements as an order specification (주문명세서).
- Serves as the authoritative source for the user's intent, goals, and constraints.
- All subsequent artifacts (`research.md`, `plan.md`, `report.md`) must align with the requirements and context defined in `prompt.md`.
- Revise `prompt.md` only when the user's requirements change materially; otherwise, preserve the original as the baseline.
- If requirements are clarified or expanded, append or annotate rather than overwrite prior content.
- Write in the user's request language, maintaining clarity and traceability to the original user input.


### research.md

- Record the current summary, stable findings, implementation constraints, and open questions.
- Keep follow-up research additive unless a finding is explicitly superseded.
- Keep summary and conclusions readable in the user's request language.
- For troubleshooting work, record the target success condition, event chain, current failure signal, one active hypothesis, and the cheapest discriminating check.
- Do not treat troubleshooting analysis as complete while those fields are still vague.

### plan.md


 - Convert research output into ordered execution steps.
 - For large or complex plans, divide the plan into sequential slices (subtasks or phases). Each slice must have a clear order, and dependencies between slices must be explicitly described.
 - Each slice should include:
	 - Purpose and scope
	 - Prerequisite slices (dependencies)
	 - Target files and changes
	 - Replacement scope and deletion candidates
	 - Validation and completion criteria
	 - Rollback triggers
 - When executing, work proceeds slice-by-slice: implement, test, and commit each slice before moving to the next.
 - If a slice fails validation, revise the plan before continuing.
 - Preserve prior planning notes when refining the plan.
 - Keep actionable steps and validation notes in the user's request language.
 - Validation planning should identify which event-chain links each test or check covers.
 - When a change replaces an older implementation path, the plan should name which path will be removed and what exception would justify retaining it.

### report.md

- Record what was implemented in the current execution stage.
- For plans divided into slices, report each slice's execution separately: describe implementation, validation results, and any issues for each slice.
- Record validation and self-review for each slice.
- Record deviations from the plan and remaining issues.
- Keep execution summaries and residual-risk notes in the user's request language.
- Report which legacy or obsolete paths were removed.
- If any legacy path remains, report why it remains, what still depends on it, and what condition should trigger later removal.
- Report which event-chain links were actually validated by tests, mocks, fixtures, or direct execution checks.
- Report whether the change reduced, preserved, or increased structural complexity.

## Completion Gate

- Keep artifacts synchronized with the actual task state.
- Do not mark a stage complete until its artifact contains enough information for the next stage or for a later session to resume safely.
