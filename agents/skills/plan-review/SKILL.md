---
name: plan-review
description: Review software implementation plans before execution. Use when a programming plan, technical approach, implementation checklist, or execution brief needs approval, critique, validation, or readiness review before an execution agent starts work.
---

# Plan Review

Act as a pre-execution gate. Decide whether an execution agent can follow the plan without guessing, drifting, or causing avoidable damage.

## Check

Look for issues that would materially affect execution:

- Contradictions, mismatched terminology, or incompatible requirements.
- Missing decisions about product behavior, architecture, data contracts, security, or ownership.
- Vague steps that force the execution agent to invent scope or implementation details.
- Unsafe assumptions about files, commands, libraries, services, credentials, or environments.
- Bad sequencing: prerequisites, migrations, generated artifacts, cleanup, or dependent changes in the wrong order.
- Cross-cutting gaps: permissions, caching, retries, concurrency, compatibility, observability, performance, or rollout.
- Verification gaps: missing tests, checks, builds, migrations validation, or manual QA for the stated risk.

If codebase context is available, inspect the relevant files before judging feasibility.

## Output

Lead with one verdict:

- **Blocked**: must be fixed before handoff.
- **Conditional Pass**: executable only if the listed assumptions or edits are added.
- **Pass**: executable as written; only minor residual risks remain.

Then list findings by severity. For each finding, include:

- What is wrong or missing.
- Why it matters.
- The exact change needed before execution.

End with **Handoff Requirements**: the minimum edits needed to make the plan executable.

## Discipline

- Block only on execution-relevant problems, not style.
- Separate must-fix items from nice-to-have improvements.
- When uncertain, state the assumption that would make the plan safe.
- If no material issues exist, say so clearly.
