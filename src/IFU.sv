module IFU #(parameter PC_WIDTH = 32, INS_WIDTH = 32) (
  input resetn,
  input clk,
  input logic stall, w_stall,
  input logic doBranch,
  input logic [PC_WIDTH-1:0] branchAdr,
  input logic [INS_WIDTH-1:0] Instr,
  output logic [PC_WIDTH-1:0] PC, PC1CK,
  output logic InstrRd,
  output logic [INS_WIDTH-1:0] IR
);
  
  always @(posedge clk or negedge resetn) begin
    if(~resetn)
      PC1CK <= 0;
    else if (doBranch)
      PC1CK <= branchAdr;
    else if (w_stall)
      PC1CK <= PC1CK;
    else
      PC1CK <= PC1CK+(PC_WIDTH/8);
  end
  
  always @(posedge clk) PC <= PC1CK;
  
  always @(posedge clk) begin
    IR <= Instr;
    InstrRd <= ~stall;
  end
  
  
endmodule