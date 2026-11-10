# Governance

VidyutSetu is maintained by **Silicon Setu**, a non-profit (Section 8) company, as an education and open-hardware asset. This document explains who decides what.

## Roles and GitHub teams

| Role | GitHub team | Who | Responsibilities |
|---|---|---|---|
| **Technical Lead** | (member of `developers`) | Appointed by the Silicon Setu board; initially the original author | Architecture direction, final say on `main`, release approval |
| **Maintainer** | `developers` | Nominated by the Technical Lead, confirmed by existing Maintainers | Review and merge PRs, triage issues, keep CI green |
| **Program Lead** | `program-leads` | A mentor, faculty member or engineer who runs a program or cohort | Defines a program's scope and backlog, vouches for its contributors, collects Contributor Agreements, writes the cohort report |
| **Org Owner** | `org-owners` | At least two Silicon Setu people | GitHub organization admin; makes sure access never depends on one person |
| **Contributor** | none (works from a fork) | Anyone: students, faculty, engineers | Opens issues and PRs following `CONTRIBUTING.md` |

Org Owners do not get merge rights on `main` just by being owners; code review goes through Maintainers.

## Repository rules
- **One protected `main` branch.** PRs only, CI must pass, one approving review from a Maintainer who is not the author, no force-push, no direct pushes.
- **Short-lived work.** Feature branches (`feature/<program>-<topic>`, deleted after merge) for members with write access, or forks for everyone else. See `docs/BRANCHING.md`.
- **Squash-merge** with a prefixed title (`rtl:`, `sim:`, `verif:`, `docs:`, `ci:`).
- **DCO sign-off** on every commit and a signed Contributor Agreement on file. See `CONTRIBUTING.md`.

## Programs
Programs organize people and tasks; they do not fork the code. Each program has:
- a folder `programs/<name>/` with its scope, schedule and report,
- an issue label `program:<name>`,
- a GitHub milestone per cohort,
- a Program Lead in the `program-leads` team.

All program work lands in `main` through PRs under the same rules.

| Program | Folder | Label | Milestone | Program Lead |
|---|---|---|---|---|
| Chip Yagna | `programs/chip-yagna/` | `program:chip-yagna` | Chip Yagna - Cohort 1 | [TO BE ASSIGNED] |

## Becoming a Maintainer
A Contributor with a sustained record of good merged work and helpful reviews may be nominated. Approval needs the Technical Lead and a majority of current Maintainers. A Maintainer inactive for 90 days becomes Emeritus and can return on request.

## Decisions
- **Routine changes:** a PR approved by one Maintainer (not the author) with CI passing.
- **Significant changes** (ISA extensions, pipeline restructuring, interface changes, new top-level directories): an RFC in `docs/rfcs/NNNN-short-title.md` (copy `docs/rfcs/0000-template.md`), open for comment at least 7 days, then decided by Maintainers by lazy consensus. The Technical Lead breaks ties.
- **License or ownership changes:** need Silicon Setu board approval.
- **Disputes and Code of Conduct matters:** go to the Silicon Setu board at admin@siliconsetu.in.

## Releases
Tagged `vMAJOR.MINOR.PATCH`. A release is cut at the close of each cohort or when the Technical Lead decides. Every release must pass the full regression in CI. `v0.1.0-baseline` marks the original code as adopted.

## Code of Conduct
We follow the Contributor Covenant 2.1. See `CODE_OF_CONDUCT.md`. Report concerns to admin@siliconsetu.in.

## Changes to this document
By PR, approved by the Technical Lead and a majority of Maintainers, and reported to the Silicon Setu board.
