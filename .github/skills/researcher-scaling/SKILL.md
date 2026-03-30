---
name: researcher-scaling
description: "Scale the researcher pool up or down by duplicating or removing researcher agent files. Use when project size, subsystem count, or context budget requires more or fewer parallel researchers in the orchestration workflow."
argument-hint: "current scope and desired researcher count"
user-invocable: true
---

# Researcher Scaling

Use this skill when the leader needs to adjust the number of researcher agents for a request.

## When to Scale Up

- The request spans multiple subsystems.
- The task needs both codebase research and external domain research.
- A single researcher artifact would become too broad for the planner or coder.
- Parallel investigation would materially reduce turnaround time.
- The estimated research payload exceeds the practical budget of one researcher.

## When to Scale Down

- The task scope has narrowed.
- Multiple researchers are producing overlapping results.
- Context budget is better spent on planning or implementation.
- Completed research artifacts can be merged and no longer need parallel maintenance.

## Capacity Model

- Assume each researcher has a total input context ceiling of 100K tokens.
- Reserve 30K tokens for instructions, user prompt, orchestration framing, and local working room.
- Treat 70K tokens as the practical research payload budget for one researcher.
- Estimate payload before scaling by using Linux commands over the likely in-scope files and references.

## Estimation Heuristic

1. Use commands such as `rg --files`, `find`, `rg`, and `wc -c` to identify and size the likely research corpus.
2. Estimate code-heavy local material at roughly 1 token per 4 bytes.
3. Estimate prose-heavy technical material at roughly 1 token per 3 bytes.
4. Add a 10K to 20K token coordination buffer for task framing and artifact overhead.
5. Compute `ceil(estimated_payload / 70000)` and use that as the starting researcher count.
6. If the result is high but the scope can be partitioned into phases, prefer staged research over spawning many researchers at once.

## Scale-Up Procedure

1. Use .github/agents/researcher.agent.md as the base file.
2. Duplicate it to a new file such as .github/agents/researcher-02.agent.md or .github/agents/researcher-03.agent.md.
3. Update the frontmatter name to a unique value.
4. Update the description to mention the assigned subdomain or research slice.
5. Assign a distinct artifact target such as research2.md or research3.md.
6. Ensure the new researcher stays user-invocable: false.
7. Give each duplicate researcher a clearly separated scope so their artifacts do not collapse into the same context slice.

## Scale-Down Procedure

1. Identify which duplicate researcher files are no longer needed.
2. Confirm their assigned scopes are already captured in existing research artifacts.
3. Remove or archive the extra researcher agent files.
4. Keep .github/agents/researcher.agent.md as the base researcher definition.
5. Preserve any completed research artifacts even if the duplicate agent file is removed.

## Guardrails

- Do not change the base mission of the researcher role.
- Only the leader manages researcher count.
- Keep researcher descriptions specific enough for delegation and discovery.
- Avoid creating more researchers than the request can actually use.