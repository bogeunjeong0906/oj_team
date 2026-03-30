---
name: delegation-visibility
description: "Make subagent execution visible to the user and reinforce the orchestration workflow when the leader might forget delegation. Use when the leader must explain who performed each stage, whether a subagent actually ran, and how the allowed subagent list should stay synchronized."
argument-hint: "request scope and current orchestration stage"
user-invocable: true
---

# Delegation Visibility

Use this skill when the leader must make subagent execution identifiable to the user and reduce workflow drift in multi-agent orchestration.

## Goals

- Let the user distinguish leader work from subagent work.
- Prevent the leader from presenting delegated work as if the leader performed it directly.
- Reduce workflow forgetting by repeating the same delegation checkpoints in multiple places.
- Keep the leader's allowed subagent list synchronized with active worker definitions.

## When to Use

- The task spans multiple orchestration stages.
- The leader might use subagents for research, planning, building, or review.
- The user needs to audit who performed each part of the work.
- The active researcher pool changed and the leader must keep allowed subagents aligned.

## Leader Reporting Contract

For non-trivial orchestration work, the leader's final response must include an `Execution Ledger` section.

Each ledger entry must report:

- `Stage`
- `Executor`
- `Output`
- `Delegation status`
- `Note`

Use only these delegation status values:

- `delegated and completed`
- `delegated but no usable result returned`
- `handled directly by leader`

## Stage Ownership Rules

- Research, planning, building, and review are separate ownership decisions.
- The research stage must not be handled directly by the leader.
- Name `Researcher` as the research-stage owner and mention `Subresearcher 01` or `Subresearcher 02` in the note when they supplied supporting slices.
- If a subagent performed a stage, name the agent exactly as defined in frontmatter.
- If multiple subagents contributed, list the primary executor first and mention the supporting executor in the note.
- If the leader handled a stage directly, say so explicitly and give a short reason.
- Never claim a stage was delegated unless a subagent actually returned a usable result.

## Workflow Reinforcement Checklist

Apply this checklist before the leader ends a non-trivial turn.

1. Identify the in-scope stages.
2. For each stage, decide whether the executor was the leader or a subagent.
3. If the researcher pool changed, update the leader `agents` list before further delegation.
4. Verify that each executor named in the ledger maps to an existing agent definition.
5. Verify that each delegated stage has a real output, artifact, or returned summary.
6. Emit the `Execution Ledger` in the final response.

## Allowed Subagent Synchronization Rules

- The leader `agents` frontmatter must always list `Researcher`, `Planner`, `Builder`, and `Reviewer`.
- It must also list every active supporting researcher such as `Subresearcher 01` or `Subresearcher 02`.
- When a supporting researcher file is created or activated, add its frontmatter name to the leader `agents` list in the same change set.
- When a supporting researcher file is removed or deactivated, remove its frontmatter name from the leader `agents` list in the same change set.
- Treat scaling work as incomplete if this synchronization step has not been done.

## Output Template

Use the template in [assets/execution-ledger.template.md](./assets/execution-ledger.template.md) when drafting or reviewing the leader response.

## Operator Notes

Use the guide in [assets/operator-guide.md](./assets/operator-guide.md) to understand how to read the ledger and how to tell whether the leader actually used subagents.