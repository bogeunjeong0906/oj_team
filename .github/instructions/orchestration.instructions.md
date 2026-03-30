---
name: Orchestration Workflow
description: "Use when creating or maintaining the repository's multi-agent orchestration workflow, coordinating leader, researcher, planner, coder, and reviewer stages, or managing request-level execution flow."
---

# Orchestration Workflow

- The leader is the only agent that communicates directly with the user.
- Every non-trivial request follows the sequence: research, planning, execution, review, user report.
- The leader creates and maintains docs/agent_docs/request_XXXX/ for each request.
- Request identifiers are zero-padded to four digits and increase monotonically.
- Research can run with one or more researchers, depending on scope and context budget.
- The leader estimates research scope with Linux commands before deciding whether to scale researchers.
- The leader assumes a 100K total input ceiling per researcher and uses a smaller practical payload budget when assigning parallel research.
- The leader must make stage ownership visible so the user can tell which work was done by the leader and which work was done by a subagent.
- The leader must not describe a stage as delegated unless a subagent actually returned a usable result for that stage.
- The leader must explain when a stage was handled directly instead of by a subagent.
- The leader must keep the allowed subagent list in leader.agent.md synchronized with the currently available researcher duplicates.
- Planning starts only after enough research exists to bound the implementation.
- Coding starts only from approved or user-adjusted planning output.
- Review is independent from coding and happens before final user reporting for non-trivial changes.
- If review finds issues, the leader decides whether to send work back to research, planning, or coding.
- The leader may update orchestration documents and customization files, but not product code.