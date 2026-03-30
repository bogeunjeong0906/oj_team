---
name: Create Next Request
description: "Use when starting request_0002 or any later orchestration request. Creates the next docs/agent_docs/request_XXXX folder, canonical artifacts, and initial researcher assignment using the Leader agent."
argument-hint: "brief task summary and optional constraints"
agent: "Leader"
---

Create the next orchestration request package for this repository.

Follow these resources:

- [Orchestration rules](../instructions/orchestration.instructions.md)
- [Artifact conventions](../instructions/agent-artifacts.instructions.md)
- [Role boundaries](../instructions/role-boundaries.instructions.md)
- [Request artifact management skill](../skills/request-artifact-management/SKILL.md)
- [Researcher scaling skill](../skills/researcher-scaling/SKILL.md)

## Required Actions

1. Inspect docs/agent_docs/ and determine the next request identifier.
2. Create the next request folder using the canonical naming scheme.
3. Create the canonical artifact set for the new request.
4. Estimate the research payload with Linux commands before assigning researchers.
5. Start with one researcher unless the payload estimate and domain split justify more.
6. If a second researcher is justified, use [researcher-02.agent.md](../agents/researcher-02.agent.md) as the first duplicate pattern.
7. Write a brief kickoff summary into research1.md and leave the remaining artifacts ready for the next stage.

## Output

Return a short operational summary that includes:

- the new request id
- which artifact files were created
- how many researchers were assigned
- the rough reasoning for that researcher count