---
name: git-commit-workflow
description: "Review, stage, and commit repository changes only when the user explicitly asks for it. Use when preparing a focused git commit, checking for unrelated changes, and writing a clear commit message without automatically committing by default."
argument-hint: "requested commit scope and optional message"
user-invocable: true
---

# Git Commit Workflow

Use this skill when the user explicitly asks for a git commit.

## Core Rules

- Do not stage or commit anything unless the user explicitly requested it.
- Review the changed files before committing.
- Exclude unrelated changes from the commit whenever possible.
- If unrelated changes cannot be safely separated, stop and explain the issue.
- Do not push unless the user explicitly asked for a push.

## Procedure

1. Inspect the changed files.
2. Determine which changes belong to the requested scope.
3. Review the diff for those files.
4. Stage only the relevant files.
5. Write a focused commit message.
6. Commit only after the scope is confirmed.
7. Push only if the user requested it.

## Commit Message Rules

- Keep the subject line specific and concise.
- Prefer describing the actual change over generic wording.
- Mention the workflow area when relevant, for example `orchestration`, `request-id`, or `builder-review`.

## Safety Checks

- Are there unrelated modified files?
- Are there generated files or temporary edits that should stay out of the commit?
- Did the user request commit only, or commit and push?

## Output Template

Use [assets/commit-summary.template.md](./assets/commit-summary.template.md) when reporting the commit result.