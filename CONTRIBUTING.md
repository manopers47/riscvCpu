# Contributing to riscvCpu

Welcome! riscvCpu is a Silicon Setu project, open to students, faculty and engineers. Read this once, then use the checklist at the bottom for every PR.

## 1. Before you start
1. Read `README.md` to understand the 5-stage pipeline (Fetch 2 clk, Decode, Execute, Memory 2 clk, Update).
2. Sign the **Contributor Agreement** (section 4 below). Your Program Lead will tell you how it is collected.
3. Pick a task: an issue labeled with your program (`program:<name>`), and `good first issue` if you are new. Comment "I'll take this" and wait to be assigned.
4. Not sure what to build? Open an issue describing it **before** writing code.

## 2. Set up
```
git clone https://github.com/siliconsetu/riscvCpu      # or your fork
cd riscvCpu/sim
make sim                                               # must pass before you change anything
```
`make sim` exits non-zero if the build or the test fails. Tools: Verilator 5.x (CI uses 5.020, the original work used 5.014) and a C++ compiler.

## 3. Working on a change
- Work in a **fork** (students) or a **feature branch** (members with write access): `feature/<program>-<short-topic>`, for example `feature/chip-yagna-rvfi-mem-check`.
- Keep PRs small and focused: one concern per PR.
- RTL changes **must** come with a test: a new or extended assembly test in `sim/`, or a check in `verif/`.
- Keep `src/` synthesizable; testbench-only code stays in `sim/` or `verif/`.
- Match the surrounding style, use meaningful signal names, and comment non-obvious pipeline behavior (stalls, flushes, latency assumptions).

## 4. Legal: sign-off and Contributor Agreement

### DCO sign-off on every commit
Every commit must carry a `Signed-off-by:` line certifying the [Developer Certificate of Origin](https://developercertificate.org/):
```
git commit -s -m "rtl: fix JALR target alignment"
```
The name and email must match your git identity. CI checks every commit in a PR. Forgot? Fix the last commit with `git commit --amend -s --no-edit`, or several with `git rebase --signoff main`, then force-push your branch.

### Contributor Agreement (once)
Before your first PR is merged, sign `legal/CONTRIBUTOR_AGREEMENT.md`. In short:
- **You keep your copyright.**
- You license your contribution to Silicon Setu, and to everyone who gets the project from it, under Apache-2.0 (and let Silicon Setu relicense under another open license if the board approves).
- You confirm the work is yours to give and no employer or university has a claim on it.

## 5. Pull requests
- Target `main` and fill in the PR template.
- CI must pass (Verilator regression and DCO check). A Maintainer other than you must approve.
- Respond to review by pushing new commits; Maintainers squash-merge.
- Don't commit generated files (`sim/vbuild/`, `*.vcd`, `*.log`).

## 6. Architecture-level changes
New ISA extensions, pipeline restructuring or interface changes need an RFC first. Copy `docs/rfcs/0000-template.md`, open a PR, and wait for the 7-day comment window. See `GOVERNANCE.md`.

## 7. Third-party code
Only include code whose license is compatible with Apache-2.0, keep its license header, add it to `NOTICE`, and mention it in the PR description. Never paste code from a course assignment, an employer, or an AI tool whose output you haven't reviewed and understood.

## 8. Conduct and privacy
Follow the [Code of Conduct](CODE_OF_CONDUCT.md). Never commit personal data (phone numbers, ID numbers, marks lists). Questions: admin@siliconsetu.in.

## PR checklist
- [ ] `make sim` passes locally
- [ ] Test added or updated for the change
- [ ] Every commit signed off (`-s`)
- [ ] Contributor Agreement signed
- [ ] Docs updated if behavior or interfaces changed
- [ ] Linked to an issue with the `program:<name>` label
