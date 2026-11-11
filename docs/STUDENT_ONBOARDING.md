# Student Onboarding: VidyutSetu

Plan for about 2 hours for your first merged contribution.

## Day 0: Accounts and tools (30 min)
- [ ] GitHub account with 2FA, a clear username, and your real name in the profile
- [ ] Join the Silicon Setu GitHub org (invite from your Program Lead)
- [ ] Install git, Verilator, a g++ toolchain, and a waveform viewer (GTKWave)
- [ ] `git config --global user.name "Your Name"` and `user.email` (use the same email as GitHub)
- [ ] Sign the Contributor Agreement and give it to your Program Lead

## Day 1: Understand the core (60 min)
1. Read `README.md` (pipeline: Fetch 2 clk, Decode, Execute, Memory 2 clk, Update; branches/jumps fixed 4 clk).
2. Fork the repo, clone your fork, then run:
   ```
   cd VidyutSetu/sim && make sim
   ```
3. Open `sim/custom-long.asm` and find 3 instructions; trace each through the RTL.
4. Look at one waveform (GTKWave) for a short sequence.

## Day 1: Your first contribution (30 min)
Pick a `good first issue`. Typical starter tasks: add an assembly test for an untested corner case, fix a lint warning, improve a comment, write a missing diagram or doc.
```
git switch -c feature/<program>-<topic>
# make the change, run make sim
git commit -s -m "docs: add pipeline timing note"
git push origin feature/<program>-<topic>
```
Open a PR to the org `main`, fill the template, respond to review.

## Rules of the road
- Ask early; a short question beats a week in the wrong direction.
- Small PRs, one idea each.
- You must understand and be able to explain every line you submit, including anything suggested by an AI assistant.
- Do not push to `main`; do not commit build output or personal data.

## Working with Claude (optional)
If your Program Lead shares the **Silicon Setu RISC-V** Claude project, use it to explain the pipeline, review your testbench ideas, and prepare PR descriptions. It does not replace mentor review, and you are responsible for the code you submit.

## Who to contact
Program Lead: [TO BE ASSIGNED]  Developers/Maintainers: see `CODEOWNERS`  Conduct concerns: admin@siliconsetu.in
