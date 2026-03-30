---
name: Create Next Request
description: "Use when starting request_0001 or any later active orchestration request. Creates or reuses the appropriate docs/agent_docs/request_XXXX folder, ignoring request_0000 which is reserved as the official template."
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
- [Delegation visibility skill](../skills/delegation-visibility/SKILL.md)
- [Request ID allocation skill](../skills/request-id-allocation/SKILL.md)

## Required Actions

1. Inspect docs/agent_docs/ and treat request_0000 as the official example and template package.
2. Determine whether the task belongs to an existing active request or needs a new request identifier.
3. If a new request is needed, create the next active request folder using the canonical naming scheme.
4. Create or update the canonical artifact set for the active request.
5. Estimate the research payload with Linux commands before assigning researchers.
6. Start with one researcher unless the payload estimate and domain split justify more.
7. If a second researcher is justified, use [researcher-02.agent.md](../agents/researcher-02.agent.md) as the first duplicate pattern.
8. If the active researcher pool changes, update the leader `agents` list to match the active researcher files.
9. Write a brief kickoff summary into research1.md and leave the remaining artifacts ready for the next stage.
10. Return an execution ledger that lets the user identify which work was done by the leader and which was delegated.

## Output

Return a short operational summary that includes:

- the new request id
- whether an existing request id was reused
- which artifact files were created
- how many researchers were assigned
- the rough reasoning for that researcher count
- the execution ledger for the kickoff step