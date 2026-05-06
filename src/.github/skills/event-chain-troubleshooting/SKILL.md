---
name: event-chain-troubleshooting
description: "Troubleshoot by modeling the minimal event chain required for success, then isolate the failing link with one falsifiable hypothesis and the cheapest discriminating check. Use when debugging, reviewing failures, or diagnosing complex workflows."
argument-hint: "failure signal, system flow, or suspected broken link"
user-invocable: true
---

# Event-Chain Troubleshooting

Use this skill when the task is not just to edit familiar code, but to find where a process or behavior actually breaks.

## Goals

- Prefer procedural diagnosis over broad pattern-matching.
- Reduce search cost by modeling only the links that must succeed for the target behavior to work.
- Localize failure with one falsifiable hypothesis at a time.

## Core Idea

A visible failure usually means one link in a required chain failed.

Examples of links:

- input acquisition
- parsing or validation
- state update
- persistence
- matching with other data
- rendering or UI output
- external side effect

The agent should identify the smallest chain that explains the behavior, then work backward or forward across that chain until the first broken link is isolated.

## Procedure

1. Define the target success condition in one sentence.
2. Break the behavior into an ordered event chain of only the required links.
3. Mark the first link that is still known-good and the first link that is visibly bad.
4. State exactly one falsifiable local hypothesis for the gap between them.
5. Choose the cheapest discriminating check that can reject that hypothesis.
6. Run that check before expanding scope.
7. If the hypothesis survives, repair the same slice and re-check.
8. If the hypothesis fails, move one link closer to the real control point and repeat.

## Evidence Priority

Prefer evidence in this order when available:

1. traceback, exception, assertion, failing test
2. existing logs or trace output
3. a narrow reproducible test, including mock-based tests if low-level dependencies are unavailable
4. targeted source reading around the controlling code path
5. broader codebase search only after the chain link and search purpose are explicit

## Search Budget Rules

- Do not start with broad repo mapping.
- Do not read many files before naming a current hypothesis.
- Use `research-find` only after choosing the target link, key symbols, or exact evidence you need.
- If the first nearby file only forwards or wires behavior, hop once to the code that computes, mutates, or decides it.

## When Runtime Access Is Limited

- If the real environment is unavailable, isolate the unavailable link and treat it as a boundary.
- Prefer mock data, fixture inputs, or controlled test doubles to mark upstream links as assumed-good.
- Then diagnose the remaining downstream logic as a smaller event chain.
- If even that is unavailable, perform source analysis link-by-link and record assumptions explicitly.

## Diagnosis Standard Before Fixing

Do not patch code until the diagnosis explains both:

- causality: why this link can produce the observed failure
- incorrectness: why the current logic is wrong, incomplete, or inconsistent

## Output Expectations

When recording findings in `research.md`, prefer including:

- target success condition
- ordered event chain
- current failure signal
- active hypothesis
- cheapest next check
- assumptions or unavailable links
