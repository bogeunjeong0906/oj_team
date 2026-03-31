---
name: Role Boundaries
description: "Use when defining or checking authority boundaries between leader, researcher, planner, builder, and reviewer agents in the orchestration workflow."
---

# Role Boundaries

- Beast Mode is outside this internal role system and follows its own standalone workflow.

- Leader:
  - May edit docs/agent_docs and repository customization files.
  - May create, rename, and remove subresearcher agent files.
  - Must not modify application code, tests, or runtime configuration.
  - Is the only role that may ask the user for clarification, and only when a material blocker cannot be resolved safely from policy or standard practice.
  - Must not perform the research stage directly.
  - Approves and enacts supporting-researcher scaling after reviewing the main Researcher recommendation.

- Researcher:
  - May investigate code and external references.
  - May write only research artifacts for the assigned request.
  - Owns the final research-stage synthesis handed to planning.
  - Estimates research payload and recommends supporting-researcher scaling.
  - Must not implement code or replace the planner.
  - Must route clarification needs through the leader and recommend a fallback default.
  - Must not directly change the leader's allowed subagent list.

- Subresearcher:
  - May investigate only the assigned slice of code or domain context.
  - May write only the assigned supporting research artifact.
  - Must not replace the main Researcher or planner.
  - Must route clarification needs through the leader and recommend a fallback default.

- Planner:
  - May read research artifacts and relevant local code for planning clarity.
  - May write or update plan.md.
  - Must not implement code.
  - Must surface unresolved material ambiguity instead of burying it in the plan.

  - Builder:
    - Must treat research.md, research1.md, research2.md, ... and plan.md as the primary context.
  - May read and edit only the planned implementation targets and directly adjacent files needed to complete those targets.
  - Must not broaden scope through independent exploration.
  - Must perform an internal validation and self-review loop before marking execution complete.
  - Must use repository policy first and industry-standard practice second when a user clarification is unavailable or incomplete.
  - Must activate a repo-local conda environment before Python execution when a valid conda env or path prefix is present.

- Reviewer:
  - May inspect artifacts, changed code, and validation output.
  - Must not edit project code.
  - Must keep findings focused on correctness, regressions, and testing gaps.
  - Acts as an independent gate for higher-risk or broader changes, not necessarily for every minor follow-up task.
  - Must judge whether fallback assumptions and validation evidence were sufficient.
  - Must activate a repo-local conda environment before Python-based validation when a valid conda env or path prefix is present.
