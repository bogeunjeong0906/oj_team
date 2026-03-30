---
name: Orchestration Workflow
description: "Use when creating or maintaining the repository's multi-agent orchestration workflow, coordinating leader, researcher, planner, builder, and reviewer stages, or managing request-level execution flow."
---

# Orchestration Workflow

- The leader is the only agent that communicates directly with the user.
- The official template request folder is docs/agent_docs/request_0000/.
- The leader must treat request_0000 as a template and example, not as an active work item.
- Every non-trivial request follows the sequence: research, planning, execution, optional independent review, user report.
- Every non-trivial request also runs a context preflight before substantial work and a Problems/lint gate before completion.
- The leader creates and maintains docs/agent_docs/request_XXXX/ for each active request.
- Active request identifiers start at request_0001, are zero-padded to four digits, and increase monotonically.
- The leader must ignore request_0000 when allocating the next active request id.
- The leader must decide whether the user's message continues an existing active request or starts a new request before writing any artifacts.
- Reuse the same active request id when the user is asking for follow-up fixes, missing pieces, small regressions, polishing, or adjacent corrections for the same primary outcome.
- Allocate a new active request id when the primary goal, subsystem, deliverable category, or implementation target materially changes.
- Research can run with one or more researchers, depending on scope and context budget.
- The leader estimates research scope with Linux commands before deciding whether to scale researchers.
- The leader assumes a 100K total input ceiling per researcher and uses a smaller practical payload budget when assigning parallel research.
- The leader must make stage ownership visible so the user can tell which work was done by the leader and which work was done by a subagent.
- The leader must not describe a stage as delegated unless a subagent actually returned a usable result for that stage.
- The leader must explain when a stage was handled directly instead of by a subagent.
- The leader must keep the allowed subagent list in leader.agent.md synchronized with the currently available researcher duplicates.
- The leader may ask the user for clarification only when missing information materially blocks a stable implementation and repository policy or standard practice cannot safely resolve it.
- Clarification should be batched into one concise round instead of repeated question loops.
- If the user cannot answer, the leader and workers must follow repository policy first and industry-standard practice second, then document the assumption.
- Planning starts only after enough research exists to bound the implementation.
- Building starts only from approved or user-adjusted planning output.
- The builder performs a built-in self-review and repair loop before handing work back to the leader.
- The builder and reviewer must confirm that touched files pass the Problems view or relevant lint gate before the request is considered complete.
- Independent review remains required for higher-risk, broader, or user-requested changes, but may be skipped for small low-risk follow-up work when the builder self-review is sufficient.
- If review finds issues, the leader decides whether to send work back to research, planning, or building.
- If independent review is skipped, the leader must say why in the Execution Ledger.
- If context risk is high, the leader should compact before substantive work begins or reduce the working set when direct compaction is unavailable.
- The leader may update orchestration documents and customization files, but not product code.
