# Branching and Program Strategy

## Principle
One project, one `main`. Programs are a way of organizing *people and tasks*, not code forks. Separate long-lived branches per program cause merge conflicts, drift in the pipeline RTL, and orphaned work when a cohort ends.

## Branches
| Branch | Purpose | Rules |
|---|---|---|
| `main` | Always-working, regression-passing core | Protected: PR only, CI required, 1 Maintainer approval, no force-push |
| `feature/<program>-<topic>` | Short-lived work for one task | Delete after merge; target lifetime under 2 weeks |
| `program/<cohort>` *(optional)* | Integration branch for a large, multi-month program whose pieces only make sense together (e.g. adding the M extension in several PRs) | Created by Program Lead with Maintainer approval; rebased/merged from `main` weekly; merged to `main` by PR when its regression passes; deleted after |
| `release/vX.Y` *(only if needed)* | Hotfix line for a version a cohort depends on | Rare |

Students without write access work in **forks** and open PRs from `feature/...` branches.

## Where program-specific things go
- **Tasks:** issues labeled `program:<name>`, grouped in a GitHub **Milestone** and a GitHub **Project** board.
- **Scope, schedule, reports:** `programs/<name>/README.md`, `report.md`.
- **Code:** in the normal tree (`src/`, `sim/`, `verif/`), merged to `main`.
- **Experimental or throwaway work:** keep in the contributor's fork, not in the org repo.

## Tags
- `v0.1.0-baseline`: the original, known-good state at adoption.
- `vX.Y.Z`: release at each cohort close. Reports reference tags.

## When a program needs real isolation
If a program wants to diverge (different ISA, ASIC-specific hacks), create a **separate repo** under the org that depends on or forks this one, and upstream general improvements by PR. Do not use a permanent branch.

## Merge policy
Squash-merge to keep `main` history readable; the PR title uses the commit prefix convention (`rtl:`, `sim:`, `verif:`, `docs:`, `ci:`).
