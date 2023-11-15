`include "defines.vh"

// Code your design here
module riscvCpu #(parameter PC_WIDTH = 32, INS_WIDTH = 32, REG_WIDTH = 32, IMMFULLWIDTH = 19, REG_ADDR_WIDTH = 5, TOTAL_REGS = 32) (
  input logic resetn,
  input logic clk,
  
  input logic [REG_WIDTH-1:0] regRdData1,
  input logic [REG_WIDTH-1:0] regRdData2,
 
  
  input logic [REG_WIDTH-1:0] memrdData,
  
  input logic [INS_WIDTH-1:0] InstrData,
  
  output logic [REG_ADDR_WIDTH-1:0] regWrAdr,
  output logic [REG_ADDR_WIDTH-1:0] regRdAdr1,
  output logic [REG_ADDR_WIDTH-1:0] regRdAdr2,
  output logic regWE,
  
  
  output logic [REG_WIDTH-1:0] regWrData,
  
  
  output logic [PC_WIDTH-1:0] memAdr,
  output logic [REG_WIDTH-1:0] memwrData,
  output logic memWE,
  

`ifndef RISCV_FORMAL
`define RISCV_FORMAL
`endif

`ifdef RISCV_FORMAL
   output reg        rvfi_valid,
   output reg [63:0] rvfi_order,
   output reg [31:0] rvfi_insn,
   output reg        rvfi_trap,
   output reg        rvfi_halt,
   output reg        rvfi_intr,
   output reg [ 1:0] rvfi_mode,
   output reg [ 1:0] rvfi_ixl,
   output reg [ 4:0] rvfi_rs1_addr,
   output reg [ 4:0] rvfi_rs2_addr,
   output reg [31:0] rvfi_rs1_rdata,
   output reg [31:0] rvfi_rs2_rdata,
   output reg [ 4:0] rvfi_rd_addr,
   output reg [31:0] rvfi_rd_wdata,
   output reg [31:0] rvfi_pc_rdata,
   output reg [31:0] rvfi_pc_wdata,
   output reg [31:0] rvfi_mem_addr,
   output reg [ 3:0] rvfi_mem_rmask,
   output reg [ 3:0] rvfi_mem_wmask,
   output reg [31:0] rvfi_mem_rdata,
   output reg [31:0] rvfi_mem_wdata,
   
   output reg [63:0] rvfi_csr_mcycle_rmask,
   output reg [63:0] rvfi_csr_mcycle_wmask,
   output reg [63:0] rvfi_csr_mcycle_rdata,
   output reg [63:0] rvfi_csr_mcycle_wdata,

   output reg [63:0] rvfi_csr_minstret_rmask,
   output reg [63:0] rvfi_csr_minstret_wmask,
   output reg [63:0] rvfi_csr_minstret_rdata,
   output reg [63:0] rvfi_csr_minstret_wdata,
`endif
  
  output logic [PC_WIDTH-1:0] InstrAdr
);
  
  
  logic [PC_WIDTH-1:0] branchAdr;
  logic [INS_WIDTH-1:0] Instr;
  logic stall;
  logic doBranch;
  logic [PC_WIDTH-1:0] PC, PC1CK;
  logic [INS_WIDTH-1:0] IR;
  logic InstrRd;
  
  logic [REG_WIDTH-1:0] rs1, rs2, rs1_data, rs2_data, opd1, opd2;
  logic [REG_ADDR_WIDTH-1:0] rs1_adr, rs2_adr, idu_rd_adr;
  logic [REG_ADDR_WIDTH-1:0] idu_rs1_adr, idu_rs2_adr;
  
  logic [2:0] funct3;
  logic [6:0] funct7;
  logic [6:0] opcode;
  logic [31:0] immVal;	
  logic [PC_WIDTH-1:0] idu_PC;
  
  logic [31:0] rslt;
  
  logic [PC_WIDTH-1:0] mem_adr;
  logic [REG_WIDTH-1:0] mem_wdata;
  logic [REG_WIDTH-1:0] mem_rdata;
  logic mem_we;
  logic [REG_WIDTH-1:0] lsu_data;
  
  logic [6:0] ex_opcode;
  logic [REG_WIDTH-1:0] ex_rs1;
  logic [REG_WIDTH-1:0] ex_rs2;
  logic [4:0] ex_rd_adr;
  logic [REG_WIDTH-1:0] ex_immVal;
  logic [PC_WIDTH-1:0] ex_PC;
  
  logic [REG_WIDTH-1:0] ruu_rdata;
  logic [REG_WIDTH-1:0] lsu_rslt;
  //logic [REG_WIDTH-1:0] lsu_data;
  logic [4:0] lsu_rd_adr;
  logic [6:0] lsu_opcode;
  logic [PC_WIDTH-1:0] lsu_PC;
  
  logic ruu_rwe;
  
  logic w_stall;
  
  IFU ifu (.*);
  IDU idu (.*);
  EXU exu (.*);
  LSU lsu (.*);
  RUU ruu (.*);
  
  
  // STALL
    
  always @(*)
    w_stall = resetn && ( (Instr[6:0] == `OPCODE_BRANCH__) || (IR[6:0] == `OPCODE_BRANCH__) || (opcode == `OPCODE_BRANCH__) || (ex_opcode == `OPCODE_BRANCH__) 
                         || (Instr[6:0] == `OPCODE_JAL_____) || (IR[6:0] == `OPCODE_JAL_____) || (opcode == `OPCODE_JAL_____) || (ex_opcode == `OPCODE_JAL_____)
                         || (Instr[6:0] == `OPCODE_JALR____) || (IR[6:0] == `OPCODE_JALR____) || (opcode == `OPCODE_JALR____) || (ex_opcode == `OPCODE_JALR____) );
  always @(posedge clk) stall <= w_stall;
  
  // IRAM
  
  assign InstrAdr = PC1CK;
  
  always @(posedge clk) begin
    if (~w_stall) Instr <= InstrData;
    else Instr <= `OPCODE_NOP_____ ;
  end
  
  // DRAM
  assign mem_rdata = memrdData;
  assign memwrData = mem_wdata;
  assign memWE = mem_we;
  assign memAdr = mem_adr;
  
  // REG Write
  
  assign regWrData = ruu_rdata;
  assign regWE = ruu_rwe && (lsu_rd_adr != 0);
  assign regWrAdr = lsu_rd_adr;
  
  // REG Read & Bypass Logic
  
  assign regRdAdr1 = rs1_adr;
  assign regRdAdr2 = rs2_adr;
  
  always @(*) rs1_data = ((lsu_rd_adr == rs1_adr) && (lsu_rd_adr !=0)) ? ruu_rdata: regRdData1;

  always @(*) if ( (ex_rd_adr == idu_rs1_adr)  && (ex_rd_adr != 0)) opd1 = rslt;
  else if ((lsu_rd_adr == idu_rs1_adr) && (lsu_rd_adr !=0)) opd1 = lsu_rslt;
  //else if ((lsu_rd_adr == rs1_adr) && (lsu_rd_adr !=0)) opd1 = ruu_rdata;
  else opd1 = rs1;

  always @(*) rs2_data = ((lsu_rd_adr == rs2_adr) && (lsu_rd_adr !=0)) ? ruu_rdata: regRdData2;
  
  always @(*) if ( (ex_rd_adr == idu_rs2_adr)  && (ex_rd_adr != 0)) opd2 = rslt;
  else if ( (lsu_rd_adr == idu_rs2_adr) && (lsu_rd_adr != 0)) opd2 = lsu_rslt;
  //else if ((lsu_rd_adr == rs2_adr) && (lsu_rd_adr !=0)) opd2 = ruu_rdata;
  else opd2 = rs2;
  
`ifdef RISCV_FORMAL
reg [31:0] exu_IR, lsu_IR;
reg [31:0] exu_opd1, exu_opd2, lsu_opd1, lsu_opd2;
reg [63:0] r_rvfi_order;

always  @(lsu_PC or resetn or rvfi_pc_rdata) begin 
    if(resetn && (lsu_PC != rvfi_pc_rdata)) begin
       rvfi_valid = 1;
       r_rvfi_order = r_rvfi_order + 1;
    end else begin
       rvfi_valid = 0;
       r_rvfi_order = r_rvfi_order;
    end
  end
  always @ (posedge clk) rvfi_order <= r_rvfi_order;

  always @ (posedge clk) rvfi_pc_rdata <= lsu_PC;
  assign rvfi_pc_wdata = lsu_PC;

  always @(posedge clk) exu_IR <= IR;
  always @(posedge clk) lsu_IR <= exu_IR;
  always @(posedge clk) rvfi_insn <= lsu_IR;

  always @(posedge clk) exu_opd1 <= opd1;
  always @(posedge clk) lsu_opd1 <= exu_opd1;
  always @(posedge clk) rvfi_rs1_rdata <= lsu_opd1;
  assign rvfi_rs1_addr = rvfi_insn[19:15];

  always @(posedge clk) exu_opd2 <= opd2;
  always @(posedge clk) lsu_opd2 <= exu_opd2;
  always @(posedge clk) rvfi_rs2_rdata <= lsu_opd2;
  assign rvfi_rs2_addr = rvfi_insn[24:20];

  assign rvfi_rd_addr = lsu_rd_adr;
  assign rvfi_rd_wdata = ruu_rdata;

`endif
endmodule
