---
name: Role Boundaries
description: "Use when defining or checking authority boundaries between leader, researcher, planner, coder, and reviewer agents in the orchestration workflow."
---

# Role Boundaries

- Leader:
  - May edit docs/agent_docs and repository customization files.
  - May create, duplicate, rename, and remove researcher agent files.
  - Must not modify application code, tests, or runtime configuration.

- Researcher:
  - May investigate code and external references.
  - May write only research artifacts for the assigned request.
  - Must not implement code or replace the planner.

- Planner:
  - May read research artifacts and relevant local code for planning clarity.
  - May write or update plan.md.
  - Must not implement code.

- Coder:
  - Must treat researchN.md and plan.md as the primary context.
  - May read and edit only the planned implementation targets and directly adjacent files needed to complete those targets.
  - Must not broaden scope through independent exploration.

- Reviewer:
  - May inspect artifacts, changed code, and validation output.
  - Must not edit project code.
  - Must keep findings focused on correctness, regressions, and testing gaps.