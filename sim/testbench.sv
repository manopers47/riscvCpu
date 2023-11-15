// Code your testbench here
// or browse Examples
`define REG_ADDR_WIDTH 5

module testbench;
  parameter PC_WIDTH = 32;
  parameter INS_WIDTH = 32;
  parameter REG_WIDTH = 32;
  parameter IMMFULLWIDTH = 19;
  parameter TOTAL_REGS = 32;

  parameter REG_ADDR_WIDTH = 5;
  logic resetn;
  logic clk;
  
  logic [REG_WIDTH-1:0] regRdData1;
  logic [REG_WIDTH-1:0] regRdData2;
 
  
  logic [REG_WIDTH-1:0] memrdData;
  
  logic [INS_WIDTH-1:0] InstrData;
  
  logic [REG_ADDR_WIDTH-1:0] regWrAdr;
  logic [REG_ADDR_WIDTH-1:0] regRdAdr1;
  logic [REG_ADDR_WIDTH-1:0] regRdAdr2;
  logic regWE;
  logic [REG_WIDTH-1:0] regWrData;
    
  logic [PC_WIDTH-1:0] memAdr;
  logic [REG_WIDTH-1:0] memwrData;
  logic memWE;
  
  logic [PC_WIDTH-1:0] InstrAdr;
  
  reg [INS_WIDTH-1:0] Iram [0:1023];
  logic [REG_WIDTH-1:0] regs [0:TOTAL_REGS-1];
  logic [REG_WIDTH-1:0] Dram[0:4095];

`ifdef RISCV_FORMAL
   reg        rvfi_valid;
   reg [63:0] rvfi_order;
   reg [31:0] rvfi_insn;
   reg        rvfi_trap;
   reg        rvfi_halt;
   reg        rvfi_intr;
   reg [ 1:0] rvfi_mode;
   reg [ 1:0] rvfi_ixl;
   reg [ 4:0] rvfi_rs1_addr;
   reg [ 4:0] rvfi_rs2_addr;
   reg [31:0] rvfi_rs1_rdata;
   reg [31:0] rvfi_rs2_rdata;
   reg [ 4:0] rvfi_rd_addr;
   reg [31:0] rvfi_rd_wdata;
   reg [31:0] rvfi_pc_rdata;
   reg [31:0] rvfi_pc_wdata;
   reg [31:0] rvfi_mem_addr;
   reg [ 3:0] rvfi_mem_rmask;
   reg [ 3:0] rvfi_mem_wmask;
   reg [31:0] rvfi_mem_rdata;
   reg [31:0] rvfi_mem_wdata;
   
   reg [63:0] rvfi_csr_mcycle_rmask;
   reg [63:0] rvfi_csr_mcycle_wmask;
   reg [63:0] rvfi_csr_mcycle_rdata;
   reg [63:0] rvfi_csr_mcycle_wdata;

   reg [63:0] rvfi_csr_minstret_rmask;
   reg [63:0] rvfi_csr_minstret_wmask;
   reg [63:0] rvfi_csr_minstret_rdata;
   reg [63:0] rvfi_csr_minstret_wdata;
   `define RISCV_FORMAL_NRET 1
   `define RISCV_FORMAL_ILEN 32
   `define RISCV_FORMAL_XLEN 32

   `define RVFI_INPUTS  \
input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_valid,      \
input [`RISCV_FORMAL_NRET *                 64   - 1 : 0] rvfi_order,      \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_ILEN   - 1 : 0] rvfi_insn,       \
input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_trap,       \
input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_halt,       \
input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_intr,       \
input [`RISCV_FORMAL_NRET *                  2   - 1 : 0] rvfi_mode,       \
input [`RISCV_FORMAL_NRET *                  2   - 1 : 0] rvfi_ixl,        \
input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs1_addr,   \
input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs2_addr,   \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs1_rdata,  \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs2_rdata,  \
input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rd_addr,    \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rd_wdata,   \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pc_rdata,   \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pc_wdata,   \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_addr,   \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_rmask,  \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_wmask,  \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata,  \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_wdata   
`define RISCV_FORMAL_CHANNEL_IDX 0
`define rvformal_const_rand_reg reg
wire [31:0] rvfi_rs1, rvfi_rs2;
   assign rvfi_rs1 = regs[rvfi_rs1_addr];
   assign rvfi_rs2 = regs[rvfi_rs2_addr];

   rvfi_reg_check reg_checker (.clock(clk), .reset(~resetn), .check(rvfi_valid), .rvfi_rs1_rdata(rvfi_rs1), .rvfi_rs2_rdata(rvfi_rs2), .*);
   reg check;
`endif
  
  riscvCpu RV32UI (.*);
  
  always forever #5 clk = ~clk;
  
  initial begin
    //#1500;
    $dumpfile("dump.vcd"); $dumpvars;
    #10000 $finish;
  end
  
  initial begin
    resetn=1;
    clk = 0;
    check = 0;
    //    stall = 0;
    
    $readmemh ("custom.hex", Iram); //branch // testsw.vec
    $readmemh ("regfile", regs);  
    
    // For Custom Tests
    Dram['h2114 >>2] = 'h00ff00ff;
    Dram['h208c >>2] = 'hff00ff00;
    
    // Custom Test Init Ends
    
    #20 resetn = 0;
    #60 resetn = 1; 
    #1 check = 1;
    print_regs;
  
    repeat (4) @(posedge clk);   
    
    $display ("Initialization Done");

    repeat (10) @ (posedge clk);
    
    do  @(posedge clk) ; while ( (regs[7] != 'h5a5) && ( regs[7] != 'ha5) );
    
    if (regs[7] == 'h5a5 ) $display ("Test passed");
    else $display ("Test Failed");
    $display ("%0t Test completed", $time);
    repeat (5) @ (posedge clk);
    print_regs;
    $finish;
    
  end
  
  //IRAM Model
  
  assign InstrData = Iram [InstrAdr>>2];

  // Dram Model  
  always @(posedge clk) memrdData <= Dram[memAdr>>2];
  always @(posedge clk) if (memWE) Dram[memAdr>>2] <= memwrData;
  
  // Reg Model
  assign regRdData1 = regs[regRdAdr1];
  assign regRdData2 = regs[regRdAdr2];
  
  always @(posedge clk) begin
    if (regWE ) begin
      regs[regWrAdr] <= regWrData;
`ifdef PROVE_RISCV_FORMAL
	regs[6] <= 0;
`endif
    
      `ifndef RISCV_FORMAL
      $display("time = %0t", $time);
      `endif
     // print_regs;
      
    end 
  end

`ifdef RISCV_FORMAL
  always @(posedge clk) begin
//    if(rvfi_valid) $display ("%0t rs1_adr = %0x, rs1_data = %0x, rs2_adr = %0x, rs2_data = %0x, rd_adr = %0x, rd_data=%0x",
//      $time, rvfi_rs1_addr, rvfi_rs1_rdata, rvfi_rs2_addr, rvfi_rs2_rdata, rvfi_rd_addr, rvfi_rd_wdata);
      if(rvfi_valid) $display ("[%0t] RVFI Monitor: PC=%05x : Ins=%x : Mnemonic: %s", $time, rvfi_pc_rdata, rvfi_insn, riscv_asm::dis_32(rvfi_insn));

  end
`endif 

  task print_regs;
    $display ("time = %t", $time);
    for (int i=0; i<4; i++) begin
        $display ("x%0d = %0x, x%0d = %0x; x%0d = %0x, x%0d = %0x, x%0d = %0x, x%0d = %0x, x%0d = %0x, x%0d = %0x",
                  i*8, regs[i*8], i*8+1, regs[i*8+1], i*8+2, regs[i*8+2], i*8+3, regs[i*8+3], 
                  i*8+4, regs[i*8+4], i*8+5, regs[i*8+5], i*8+6, regs[i*8+6], i*8+7, regs[i*8+7]);
       //$display ("x%0d = %x", i, regs[i]);
       end 
  endtask
  
endmodule
