# Subagent Visibility Guide

Use this guide to interpret leader responses.

## What to Look For

- `Execution Ledger` should appear in non-trivial orchestration responses.
- Each stage should identify one executor.
- `Delegation status` should make it clear whether a subagent actually ran.

## How to Tell Whether the Leader Used a Subagent

- `delegated and completed` means the leader is claiming a subagent produced a usable result.
- `delegated but no usable result returned` means a delegation attempt did not produce a usable output.
- `handled directly by leader` means the leader says no subagent result was used for that stage.
- For the research stage, `handled directly by leader` should be treated as a workflow violation.

## How to Cross-Check

- Compare the reported output with the artifact files in docs/agent_docs/request_XXXX/.
- Compare the executor names with the agent names defined in .github/agents/.
- If supporting researchers were used, check whether leader.agent.md includes the same subresearcher names in the `agents` list.

## Expected Operator Outcome

- You should be able to identify who handled each stage without inspecting hidden chain-of-thought or internal tool state.
- If the ledger and the artifacts disagree, treat that as an orchestration defect.
