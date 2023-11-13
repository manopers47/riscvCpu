sim:
	verilator --cc --Mdir vbuild --prefix Vtop --binary -Wno-INITIALDLY -Wno-lint -Wno-BLKANDNBLK -Wno-UNOPTFLAT -Wno-ZERODLY --top-module testbench --assert -f modules.f  testbench.sv -I../src -I. --assert --trace  --bbox-unsup -top-module testbench 2>&1 | tee vlt_comp.log  ; ./vbuild/Vtop 2>&1 | tee vlt_comp.log

clean:
	rm *.vcd *.log; rm -rf vbuild 
