sim:
	verilator --cc --Mdir vbuild --prefix Vtop --binary -Wno-INITIALDLY -Wno-lint -Wno-BLKANDNBLK -Wno-UNOPTFLAT -Wno-ZERODLY --top-module testbench --assert -f modules.f  riscv_asm.sv testbench.sv rvfi_reg_check.sv -I../src -I. +define+RISCV_FORMAL=1 --assert --trace  --bbox-unsup -top-module testbench 2>&1 | tee vlt_comp.log  ; ./vbuild/Vtop 2>&1 | tee vlt_comp.log

clean:
	rm *.vcd *.log; rm -rf vbuild 
