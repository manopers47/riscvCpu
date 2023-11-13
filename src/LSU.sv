`include "defines.vh"

module LSU #(parameter REG_WIDTH = 32, PC_WIDTH = 32) (
  input logic clk,
  input logic resetn,
  input logic [REG_WIDTH-1:0] rslt,
  input logic [6:0] ex_opcode,
  input logic [REG_WIDTH-1:0] mem_rdata,
  input logic [REG_WIDTH-1:0] ex_rs1,
  input logic [REG_WIDTH-1:0] ex_immVal,
  input logic [REG_WIDTH-1:0] ex_rs2,
  input logic [4:0] ex_rd_adr,
  input logic [PC_WIDTH-1:0] ex_PC,
  
  //output logic [PC_WIDTH-1:0] mem_adr,
  //output logic [REG_WIDTH-1:0] mem_wdata,
  //output logic mem_we,
  output logic [REG_WIDTH-1:0] lsu_data,
  output logic [4:0] lsu_rd_adr,
  output logic [REG_WIDTH-1:0] lsu_rslt,
  output logic [6:0] lsu_opcode,
  output logic [PC_WIDTH-1:0] lsu_PC
  
);
  
  /*
  assign mem_we = (ex_opcode == `OPCODE_STORE___);
  assign mem_wdata = (ex_opcode == `OPCODE_STORE___)? ex_rs2:0;
  assign mem_adr = (ex_opcode == `OPCODE_STORE___ || ex_opcode == `OPCODE_LOAD____)? (ex_rs1 + ex_immVal):0;
  */
  
 
  

  always @(posedge clk) lsu_data <= (ex_opcode == `OPCODE_LOAD____)? mem_rdata: lsu_data;
  
  always @(posedge clk) lsu_rslt <= rslt;
  always @(posedge clk) lsu_opcode <= ex_opcode;
  always @(posedge clk) lsu_rd_adr <= ex_rd_adr;
  
  always @(posedge clk) lsu_PC <= ex_PC;
  
endmodule