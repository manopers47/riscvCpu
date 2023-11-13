`include "defines.vh"
module RUU #(parameter REG_WIDTH = 32, PC_WIDTH = 32) (
  input logic clk,
  input logic [REG_WIDTH-1:0] lsu_data,
  input logic [REG_WIDTH-1:0] lsu_rslt,
  input logic [6:0] lsu_opcode,
  input logic [PC_WIDTH-1:0] lsu_PC,
  output logic [REG_WIDTH-1:0] ruu_rdata,
  output logic ruu_rwe
);
  
  assign ruu_rdata = (lsu_opcode == `OPCODE_LOAD____) ? lsu_data : ((lsu_opcode == `OPCODE_JAL_____) || (lsu_opcode == `OPCODE_JAL_____)) ? (lsu_PC + 4) : lsu_rslt;
  assign ruu_rwe = (lsu_opcode==`OPCODE_LOAD____) ? 1 :
    (lsu_opcode==`OPCODE_LUI_____) ? 1 :
    (lsu_opcode==`OPCODE_AUIPC___) ? 1 :
    (lsu_opcode==`OPCODE_JAL_____) ? 1 :
    (lsu_opcode==`OPCODE_JALR____) ? 1 :
    (lsu_opcode==`OPCODE_OP______) ? 1 :
    (lsu_opcode==`OPCODE_OP_IMM__) ? 1 : 0;

endmodule