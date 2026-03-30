---
name: Create Next Request
description: "Use when the internal Leader workflow needs request_0001 or any later active orchestration request. Creates or reuses the appropriate docs/agent_docs/request_XXXX folder, ignoring request_0000 which is reserved as the official template. Never use this prompt for Beast Mode."
argument-hint: "brief task summary and optional constraints"
agent: "Leader"
---

Create the next orchestration request package for this repository.

Do not use this prompt for Beast Mode. Beast Mode is a standalone external agent and must not create or reuse active request folders for its own execution.

Follow these resources:

- [Orchestration rules](../instructions/orchestration.instructions.md)
- [Artifact conventions](../instructions/agent-artifacts.instructions.md)
- [Role boundaries](../instructions/role-boundaries.instructions.md)
- [Request artifact management skill](../skills/request-artifact-management/SKILL.md)
- [Researcher scaling skill](../skills/researcher-scaling/SKILL.md)
- [Delegation visibility skill](../skills/delegation-visibility/SKILL.md)
- [Request ID allocation skill](../skills/request-id-allocation/SKILL.md)
- [Context preflight](../skills/context-preflight/SKILL.md)

## Required Actions

1. Inspect docs/agent_docs/ and treat request_0000 as the official example and template package.
2. Determine whether the task belongs to an existing active request or needs a new request identifier.
3. If a new request is needed, create the next active request folder using the canonical naming scheme.
4. Create or update the canonical artifact set for the active request.
5. Run context preflight before broad research or request creation work.
6. Estimate the research payload with Linux commands before assigning researchers.
7. Always assign [Researcher](../agents/researcher.agent.md) as the research-stage owner.
8. If a broader scope justifies parallel research, activate [subresearcher-01.agent.md](../agents/subresearcher-01.agent.md) and then [subresearcher-02.agent.md](../agents/subresearcher-02.agent.md) in that order.
9. If the active research pool changes, update the leader `agents` list to match the active subresearcher files.
10. Prepare research1.md for the main Researcher synthesis and add research2.md or research3.md only when subresearchers are needed.
11. Return an execution ledger that lets the user identify which work was done by the leader and which was delegated.

## Output

Return a short operational summary that includes:

- the new request id
- whether an existing request id was reused
- which artifact files were created
- how many researchers were assigned
- the rough reasoning for that researcher count
- the execution ledger for the kickoff step