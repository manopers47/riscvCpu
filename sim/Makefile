# Bash with pipefail so a failing compile or simulation is not hidden by tee.
SHELL := /bin/bash
.SHELLFLAGS := -o pipefail -c

VFLAGS = --cc --Mdir vbuild --prefix Vtop --binary \
	-Wno-INITIALDLY -Wno-lint -Wno-BLKANDNBLK -Wno-UNOPTFLAT -Wno-ZERODLY \
	--top-module testbench --assert --trace --bbox-unsup \
	-I../src -I. +define+RISCV_FORMAL=1

.PHONY: sim build run clean

sim: build run

build:
	verilator $(VFLAGS) -f modules.f rv32i_disasm.sv testbench.sv rvfi_reg_check.sv 2>&1 | tee vlt_comp.log

run:
	./vbuild/Vtop 2>&1 | tee vlt_sim.log

clean:
	rm -f *.vcd *.log; rm -rf vbuild
