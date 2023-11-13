`define REG_ADDR_WIDTH 5
`include "defines.vh"

module EXU #( parameter REG_WIDTH = 32, PC_WIDTH = 32) (
  input logic resetn,
  input logic clk,
  input logic [`REG_ADDR_WIDTH-1:0] idu_rd_adr,
  input logic [REG_WIDTH-1:0] opd1,
  input logic [REG_WIDTH-1:0] opd2,
  input logic [2:0] funct3,
  input logic [6:0] funct7,
  input logic [6:0] opcode,
  input logic [REG_WIDTH-1:0] immVal,
  input logic [PC_WIDTH-1:0] idu_PC,
  input logic [PC_WIDTH-1:0] lsu_PC,
  
  output logic [6:0] ex_opcode,
  output logic [REG_WIDTH-1:0] ex_rs1,
  output logic [REG_WIDTH-1:0] ex_rs2,
  output logic [REG_WIDTH-1:0] ex_immVal,
  output logic [REG_WIDTH-1:0] rslt,
  output logic [4:0] ex_rd_adr,
  output logic doBranch,
  output logic [PC_WIDTH-1:0] branchAdr,
  
  output logic [PC_WIDTH-1:0] mem_adr,
  output logic [REG_WIDTH-1:0] mem_wdata,
  output logic mem_we,
  
  output logic [PC_WIDTH-1:0] ex_PC
);
 
  
  wire [31:0] w_in2 = (opcode ==`OPCODE_OP_IMM__) ? immVal : (opcode == `OPCODE_AUIPC___) ? ex_PC + immVal: opd2;
  wire [31:0] w_in1 = opd1;
  
  wire signed [31:0] ws_in1 = w_in1;
  wire signed [31:0] ws_in2 = w_in2;
  
  wire [4:0] w_shamt = w_in2[4:0];
  logic branchTkn;
  logic [REG_WIDTH-1:0] w_rslt;
  
  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      branchAdr <=0; 
      doBranch <= 0;
    end else begin
      branchAdr <= (opcode==`OPCODE_JALR____) ? opd1 + immVal : (opcode == `OPCODE_JAL_____) ? lsu_PC /* ex_PC */ + immVal : ex_PC + immVal;
      doBranch  <= (opcode==`OPCODE_JAL_____ || opcode==`OPCODE_JALR____) ? 1 :
      (opcode==`OPCODE_BRANCH__) ? branchTkn : 0;
    end
  end
  
  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      rslt<=0;
    else if ((opcode == `OPCODE_OP______) || (opcode == `OPCODE_OP_IMM__) || (opcode == `OPCODE_AUIPC___) || (opcode ==  `OPCODE_JALR____) )
      rslt <= w_rslt;
    else if (opcode == `OPCODE_LUI_____) 
      rslt <= immVal;
    else 
      rslt <=0;
  end
  
  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      ex_opcode <= 0;
      ex_rs1 <= 0;
      ex_rs2 <= 0;
      ex_immVal <= 0;
      ex_rd_adr <= 0;
      ex_PC <= 0;
    end else begin
      ex_opcode <= opcode;
      ex_rs1 <= opd1;
      ex_rs2 <= opd2;
      ex_immVal <= immVal;
      ex_rd_adr <= idu_rd_adr;
      ex_PC <= idu_PC;
    end
  end
  
  always@(*) begin
    if (opcode == `OPCODE_AUIPC___) w_rslt = w_in1 + w_in2;
    else if (opcode == `OPCODE_JALR____) w_rslt = idu_PC;
    else
        case (funct3)
          `FUNCT3_ADD___ : w_rslt = (funct7 && (opcode == `OPCODE_OP______)) ? w_in1 - w_in2 : w_in1 + w_in2;
            `FUNCT3_SLL___ : w_rslt = w_in1 << w_shamt;
            `FUNCT3_SLT___ : w_rslt = {31'b0, w_in1 < w_in2};
            `FUNCT3_SLTU__ : w_rslt = {31'b0, w_in1 < w_in2};
            `FUNCT3_XOR___ : w_rslt = w_in1 ^ w_in2;
            `FUNCT3_SRL___ : begin
               if(funct7[5]) w_rslt = w_in1 >>> w_shamt;
               else          w_rslt = w_in1   >> w_shamt;
             end
            `FUNCT3_OR____ : w_rslt = w_in1 | w_in2;
            `FUNCT3_AND___ : w_rslt = w_in1 & w_in2;
            default        : begin
                rslt = 0;
            end
        endcase
  end

  always@(*) begin
        case(funct3)
            `FUNCT3_BEQ___ : branchTkn = w_in1 == w_in2;
            `FUNCT3_BNE___ : branchTkn = w_in1 != w_in2;
            `FUNCT3_BLT___ : branchTkn = ws_in1 < ws_in2;
            `FUNCT3_BGE___ : branchTkn = ws_in1 >= ws_in2;
            `FUNCT3_BLTU__ : branchTkn = w_in1 < w_in2;
            `FUNCT3_BGEU__ : branchTkn = w_in1 >= w_in2;
            default        : branchTkn = 0;
        endcase
  end
  
  assign mem_we = (opcode == `OPCODE_STORE___);
  assign mem_wdata = (opcode == `OPCODE_STORE___)? opd2:0;
  assign mem_adr = (opcode == `OPCODE_STORE___ || opcode == `OPCODE_LOAD____)? (opd1 + immVal):0;
  
  
endmodule
  
  
