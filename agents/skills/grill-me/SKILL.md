---
name: grill-me
description: Selectively stress-test a plan or design by asking only high-leverage questions that could materially change the outcome. Use when user wants to be grilled, stress-test a plan, pressure-test a design, or mentions "grill me".
---

# Selective Grilling

Stress-test the user's plan like a sharp collaborator, not a survey form.

## Triage First

Before asking anything, identify the 2-4 highest-risk uncertainties. Prefer questions about:

- Decisions that change architecture, sequencing, scope, cost, or user-facing behavior
- Hidden constraints that could invalidate the plan
- Ambiguous domain language or ownership boundaries
- Tradeoffs where the user likely has context the codebase cannot reveal

Skip questions when the answer is obvious, low-impact, stylistic, or easy to infer.

## Ask Sparingly

Ask one question at a time. For each question:

- Explain briefly why it matters
- Provide your recommended answer
- State the assumption you will make if the user does not care

Do not ask for details you can discover by reading files, running safe commands, or inspecting the codebase. Go explore instead.

## Stop Condition

Aim for the fewest questions needed to de-risk the plan, usually 3-7 total. Stop grilling when the remaining uncertainty would not materially change what to do next; summarize the working assumptions and move toward a concrete plan.
