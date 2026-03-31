---
name: request-artifact-management
description: "Create and maintain docs/agent_docs request folders and workflow artifacts. Use when generating request_XXXX directories, reusing an active request for same-context follow-up work, treating request_0000 as the official template, or standardizing research.md, researchN.md, plan.md, report.md, and review.md artifacts for the orchestration team or TAS."
argument-hint: "request id or task scope"
user-invocable: true
---

# Request Artifact Management

Use this skill when the orchestration workflow or TAS standalone workflow needs a new request folder or when an agent must create or update the standard artifact set.

Do not use this skill for Beast Mode's own execution flow.

## Responsibilities

- Determine whether to reuse an active request or allocate a new one.
- Treat request_0000 as the official template and example package.
- Create or update the canonical artifact files.
- Keep artifact naming and structure consistent across requests.

## Procedure

1. Read the request-id-allocation skill before deciding which request folder to use.
2. Inspect docs/agent_docs/ and ignore request_0000 when identifying active request ids.
3. Reuse the current active request when the new user message is a small continuation, correction, or polish pass for the same primary outcome.
4. Create a new active request folder only when the scope materially changes.
5. Create only the artifacts needed for the current stage, but preserve canonical names.
6. Use the templates in [assets](./assets/) when creating a new artifact from scratch.
7. Do not merge multiple workflow stages into a single document.


## Canonical Artifact Set

- research.md (Main Researcher)
- research1.md, research2.md, ... (Subresearcher N)
- plan.md
- report.md
- review.md

## Notes

- Main Researcher output is always research.md. Subresearcher outputs are named research1.md, research2.md, ... in the order assigned.
- review.md is mandatory when an independent reviewer is used.
- TAS normally stops at report.md and records self-review there unless an explicit independent review is requested.
- request_0000 is reserved for the official example and template set.
- If a request loops back for more work, update the existing folder instead of creating a new request id unless the scope has materially changed.