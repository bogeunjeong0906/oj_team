---
name: request-artifact-management
description: "Create and maintain docs/agent_docs request folders and workflow artifacts. Use when generating request_XXXX directories, researchN.md files, plan.md, report.md, review.md, or when standardizing artifact templates for the orchestration team."
argument-hint: "request id or task scope"
user-invocable: true
---

# Request Artifact Management

Use this skill when the orchestration workflow needs a new request folder or when an agent must create or update the standard artifact set.

## Responsibilities

- Determine the next request identifier in the form request_0001.
- Create or update the canonical artifact files.
- Keep artifact naming and structure consistent across requests.

## Procedure

1. Inspect docs/agent_docs/ and find the highest existing request number.
2. Create the next request folder using four-digit zero padding.
3. Create only the artifacts needed for the current stage, but preserve canonical names.
4. Use the templates in [assets](./assets/) when creating a new artifact from scratch.
5. Do not merge multiple workflow stages into a single document.

## Canonical Artifact Set

- research1.md, research2.md, ...
- plan.md
- report.md
- review.md

## Notes

- Researcher outputs are numbered in the order they are assigned.
- review.md is mandatory for non-trivial implementation work.
- If a request loops back for more work, update the existing folder instead of creating a new request id unless the scope has materially changed.