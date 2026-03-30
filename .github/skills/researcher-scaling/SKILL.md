---
name: researcher-scaling
description: "Scale the supporting research pool up or down by activating or deactivating subresearcher agent files and updating the leader's allowed subagent list. Use when project size, subsystem count, or context budget requires more or fewer parallel research slices in the orchestration workflow."
argument-hint: "current scope and desired researcher count"
user-invocable: true
---

# Researcher Scaling

Use this skill when the leader needs to adjust the number of supporting research agents for an internal request.

## When to Scale Up

- The request spans multiple subsystems.
- The task needs both codebase research and external domain research.
- A single researcher artifact would become too broad for the planner or builder.
- Parallel investigation would materially reduce turnaround time.
- The estimated research payload exceeds the practical budget of the main Researcher alone.

## When to Scale Down

- The task scope has narrowed.
- Multiple researchers are producing overlapping results.
- Context budget is better spent on planning or implementation.
- Completed research artifacts can be merged and no longer need parallel maintenance.

## Capacity Model

- Assume each research-role agent has a total input context ceiling of 100K tokens.
- Reserve 30K tokens for instructions, user prompt, orchestration framing, and local working room.
- Treat 70K tokens as the practical research payload budget for one agent.
- Estimate payload before scaling by using Linux commands over the likely in-scope files and references.

## Estimation Heuristic

1. Use commands such as `rg --files`, `find`, `rg`, and `wc -c` to identify and size the likely research corpus.
2. Estimate code-heavy local material at roughly 1 token per 4 bytes.
3. Estimate prose-heavy technical material at roughly 1 token per 3 bytes.
4. Add a 10K to 20K token coordination buffer for task framing and artifact overhead.
5. Keep Researcher as the required base agent and use `ceil(estimated_payload / 70000)` only to decide whether supporting subresearchers are justified.
6. If the result is high but the scope can be partitioned into phases, prefer staged research over unnecessary parallel slices.

## Scale-Up Procedure

1. Keep .github/agents/researcher.agent.md as the mandatory research-stage owner.
2. Activate .github/agents/subresearcher-01.agent.md as the first supporting file when a second research slice is justified.
3. Activate .github/agents/subresearcher-02.agent.md as the second supporting file only when a third slice is justified.
4. Assign distinct artifact targets such as research2.md and research3.md.
5. Ensure each supporting researcher stays user-invocable: false.
6. Add the active supporting researchers' frontmatter names to the `agents` list in .github/agents/leader.agent.md.
7. Give each supporting researcher a clearly separated scope so their artifacts do not collapse into the same context slice.
8. Require the main Researcher to synthesize supporting artifacts into the final research handoff.

## Scale-Down Procedure

1. Identify which supporting researchers are no longer needed.
2. Confirm their assigned scopes are already captured in existing research artifacts and the main Researcher synthesis.
3. Remove the retired supporting researcher's frontmatter name from the `agents` list in .github/agents/leader.agent.md.
4. Keep .github/agents/researcher.agent.md as the base researcher definition.
5. Preserve any completed research artifacts even if a supporting researcher is deactivated.

## Allowed Subagent List Synchronization

Use this procedure every time the active researcher pool changes.

1. Read .github/agents/leader.agent.md and inspect the `agents` frontmatter array.
2. Read the active research-support files under .github/agents/ and collect their frontmatter `name` values.
3. Ensure the leader `agents` list always contains:
  - `Researcher`
  - every active supporting researcher such as `Subresearcher 01` or `Subresearcher 02`
  - `Planner`
  - `Builder`
  - `Reviewer`
4. Remove stale supporting-researcher names from the leader `agents` list when their files are removed.
5. Do not add file paths to the `agents` list. Use frontmatter names only.
6. After syncing, verify that each listed agent name maps to an existing agent file with the same frontmatter name.

## Guardrails

- Do not change the base mission of the main Researcher role.
- Only the leader manages supporting researcher count.
- Keep supporting researcher descriptions specific enough for delegation and discovery.
- Avoid activating more supporting researchers than the request can actually use.
- Treat supporting researcher activation or removal as incomplete until the leader `agents` list is synchronized.