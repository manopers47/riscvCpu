# riscvCpu

[![CI](https://github.com/siliconsetu/riscvCpu/actions/workflows/ci.yml/badge.svg)](https://github.com/siliconsetu/riscvCpu/actions/workflows/ci.yml)

A Silicon Setu open-hardware project. The RTL top module is `riscvCpu`.

A keep it simple (and stupid) version of RISC-V implementation in SystemVerilog RTL and simulated using Verilator
1) Implements RU32UI Instruction Set (Around 20+ unique instructions as of now - Integer Computating, Control Transfer, Load and Store) - See sim/custom-long.asm for all tested instructions
2) It is implemented as a 5 stage Pipeline with a max of 7 clocks fixed latency - and near single clock Instruction throughput in the absence of branch/jumps
  a) Fetch (2clks), Decode, Execute, Memory(2clks) and Update
  b) Brranches/Jumps have fixed 4clk latency
  c) Imem and Dmem accesses are 2clk synchronous
4) regs, Imem and Dmem are basic simulation models
5) riscvCpu is the main cpu RTL module
6) Contains basic Testbench which loads the g++ assembled image of sim/custom-long.asm - image file name sim/custom.hex and starts the cpu [created from riscv-tests](https://github.com/riscv-software-src/riscv-tests)
7) RVFI interface (partially implemented) - and basic register check Assertion added as sample - RVFi can be expanded for full instruction check, mem check and other RISCV-FORMAL support can be fully added
8) Code simulated in Verilator ver 5.014
9) This is a work in progress Project. End target is to build the least minimum configuration of RISCV CPU in hardware which can boot Linux 5.xxx kernel on a text console
10) For more details on the development history see: [30 days with a #riscv 32ui architecture - part I](https://www.linkedin.com/feed/update/urn:li:activity:7128997010409459712/ )

## To run this design
```
git clone https://github.com/siliconsetu/riscvCpu
cd riscvCpu/sim
make sim      # exits non-zero if the test fails
```

## Contributing
See [CONTRIBUTING.md](CONTRIBUTING.md) (DCO sign-off and Contributor Agreement), [GOVERNANCE.md](GOVERNANCE.md) and [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md). Programs such as [Chip Yagna](programs/chip-yagna/README.md) organize work on this core.

## License
Apache License 2.0. See [LICENSE](LICENSE) and [NOTICE](NOTICE); third-party license texts are in [LICENSES/](LICENSES/). Versions up to `v0.1.0-baseline` were released under GPL-3.0.

Contact: admin@siliconsetu.in
