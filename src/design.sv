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
  
endmodule