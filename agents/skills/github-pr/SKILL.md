---
name: github-pr
description: Prepare, publish, and maintain GitHub pull requests with template-faithful descriptions, fewer pushes, and CI follow-through. Use when creating, updating, pushing, or checking a GitHub PR, or when the user asks to open, ship, publish, or polish a PR.
---

# GitHub PR Workflow

Optimize for a reviewer-friendly PR with low CI noise.

## PR Shape

- Use the repository PR template as the source of truth. Preserve its headings, prompts, and checkboxes.
- If there is no template, keep the body compact: summary, verification, risks or rollout notes when relevant.
- Explain reviewer-relevant intent: what changed, why, what to watch. Do not mechanically restate the diff.
- Keep the commit/story shape reviewable. Do not squash, split, reorder, or rewrite existing user commits unless the user agrees.

## Push Discipline

- Treat push/open/update as the noisy boundary: it triggers remote checks and may notify reviewers.
- Before the first push, assemble a coherent local commit stack rather than pushing every small fix.
- After CI or review feedback, batch related fixes locally and push them together.
- Ask before pushing or opening/updating a PR unless the user has already explicitly asked for that action.

## Checks

- After pushing or updating a PR, wait for PR checks to finish. Do not declare the PR done while checks are pending.
- If checks fail, inspect the failing checks/logs before changing code.
- Fix failures locally, batch related fixes into a coherent commit or commit set, push once, then wait again.
- Continue until checks pass, or stop only when the failure is external, blocked by missing access/secrets, or the user asks to pause. Report the concrete blocker and current PR state.
