---
name: pytest-quality-gate
description: "Design pytest validation around the event chain being verified, requiring explicit coverage of failure reproduction, happy path, boundary conditions, and regression protection when relevant. Use for Python changes or for planning Python validation."
argument-hint: "target behavior, failure link, or planned pytest coverage"
user-invocable: true
---

# Pytest Quality Gate

Use this skill when Python logic is changed, when debugging with pytest, or when planning validation for Python behavior.

## Goals

- Make pytest prove the right thing, not just pass.
- Tie each test to an event-chain link or failure condition.
- Avoid wide, slow, low-signal tests when a narrower check can falsify the diagnosis.

## Minimum Test Set

When relevant to the change, cover these four perspectives:

1. failure reproduction test
2. happy path test
3. boundary or edge condition test
4. regression guard for a nearby behavior that must not break

If one of these does not apply, state why instead of silently skipping it.

## Link Mapping Rule

For each important test, record:

- assumed-good links
- verified link
- evidence signal, such as returned value, state change, exception, or persisted output

## Mock And Fixture Rule

- Use mocks or fixtures to freeze unavailable or already-proven upstream links.
- Do not mock the very link the test claims to verify.
- State why the mocked link is being treated as assumed-good.

## Scope Rule

- Prefer the narrowest test that can reject the current hypothesis.
- Escalate to broader integration-style tests only when the failure could plausibly be in the interaction between links.

## Completion Checklist

- failure reproduction covered or explicitly not applicable
- happy path covered or explicitly not applicable
- boundary condition covered or explicitly not applicable
- regression guard covered or explicitly not applicable
- each important test mapped to the link it verifies

## Output Template

Use [assets/test-linkage.template.md](./assets/test-linkage.template.md) when recording the test design or test result.