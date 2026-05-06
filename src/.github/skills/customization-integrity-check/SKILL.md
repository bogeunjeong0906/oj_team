---
name: customization-integrity-check
description: "Check that README, agent, instruction, skill, prompt, and asset references inside the customization repository still point to real files after structural changes. Use after adding, removing, or renaming customization files."
argument-hint: "changed customization files or structural refactor"
user-invocable: true
---

# Customization Integrity Check

Use this skill whenever the customization repository structure changes.

## Goals

- Catch broken internal links early.
- Prevent README and agent guidance from drifting away from the real file tree.
- Give TAS a repeatable post-change integrity routine.

## What To Check

- Markdown links in `README.md`
- Markdown links in `.github/**/*.md`
- skill asset links
- instruction links referenced by agents or documents

## Procedure

1. Run the integrity checker script.
2. Fix any missing referenced file or broken relative path.
3. Re-run the checker until it passes.
4. Record the result in the current report or summary when the structure changed materially.

## Manual Follow-Up

- If the checker passes, still verify that README structure prose matches the real directory layout.
- If a path is intentionally removed, remove or replace all references in the same slice.

## Output Template

Use [assets/integrity-check.template.md](./assets/integrity-check.template.md) when recording the result.