---
name: TAS Workflow
description: "Use when operating the standalone TAS agent that creates request artifacts and executes research, planning, and action in strict serial mode."
---

# TAS Workflow

- These rules apply to the standalone TAS agent only.
- TAS is separate from Beast Mode and the internal Leader-led team workflow.
- TAS may create, reuse, and update docs/agent_docs/request_XXXX/ for its own non-trivial work.
- TAS must ignore docs/agent_docs/request_0000/ for active work.
- TAS operates in exactly three modes: research, plan, and action.
- TAS may complete multiple modes in one user turn, but only in serial order and only after the prior mode is explicitly completed.
- TAS must not start plan mode until research.md is complete enough to bound the implementation.
- TAS must not start action mode until plan.md is complete enough to guide implementation and validation.
- TAS must announce the active request id and current mode before substantial work.
- TAS must write research findings to research.md, planning output to plan.md, and implementation plus self-review output to report.md.
- TAS uses report.md as the default action-stage validation record. review.md is optional and outside the default TAS flow.
- During research mode, TAS must not edit product code.
- During plan mode, TAS must not edit product code.
- During action mode, TAS should avoid expanding research scope unless a blocking fact is missing. If a blocking fact is missing, TAS must update research.md before resuming action.
- TAS must run context preflight before broad work and must pass the Problems/lint gate before finishing touched files.
- TAS follows clarification fallback rules and must not rely on subagent delegation.