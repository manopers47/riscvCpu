`define REG_ADDR_WIDTH 5
`include "defines.vh"

module IDU  #(parameter REG_WIDTH = 32, INS_WIDTH = 32, IMMFULLWIDTH = 19, TOTAL_REGS=32, PC_WIDTH = 32)(
  input logic resetn,
  input logic clk,
  input logic [INS_WIDTH-1:0] IR,
  input logic [REG_WIDTH-1:0] rs1_data,
  input logic [REG_WIDTH-1:0] rs2_data,
  input logic [PC_WIDTH-1:0] PC,
  output logic [`REG_ADDR_WIDTH-1:0] rs1_adr,
  output logic [`REG_ADDR_WIDTH-1:0] rs2_adr,
  output logic [`REG_ADDR_WIDTH-1:0] idu_rs1_adr,
  output logic [`REG_ADDR_WIDTH-1:0] idu_rs2_adr,
  output logic [`REG_ADDR_WIDTH-1:0] idu_rd_adr,
  output logic [REG_WIDTH-1:0] rs1,
  output logic [REG_WIDTH-1:0] rs2,
  output logic [2:0] funct3,
  output logic [6:0] funct7,
  output logic [6:0] opcode,
  output logic [31:0] immVal,
  output logic [PC_WIDTH-1:0] idu_PC
  
);
  
    
  assign rs1_adr = IR[19:15];
  assign rs2_adr = IR[24:20];
 
  
  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      rs1 <= 0;
      rs2 <= 0;
      idu_rs1_adr <= 0;
      idu_rs2_adr <= 0;
      opcode <= 0;
      funct7 <= 0;
      funct3 <= 0;
      idu_rd_adr <= 0;
      idu_PC <= 0;
    end else begin
      rs1 <= rs1_data;
      rs2 <= rs2_data;  
      idu_rs1_adr <= rs1_adr;
      idu_rs2_adr <= rs2_adr;
      opcode <= w_opcode;
      funct7 <= IR[31:25];
      funct3 <= IR[14:12];
      idu_rd_adr <= IR[11:7];
      idu_PC <= PC;
    end
  end
  
  wire [6:0] w_opcode = IR[6:0];
  wire [31:0] imm_I = { {21{IR[31]}}, IR[30:25], IR[24:20] };
  wire [31:0] imm_S = { {21{IR[31]}}, IR[30:25], IR[11:8], IR[7] };
  wire [31:0] imm_B = { {20{IR[31]}}, IR[7],IR[30:25] ,IR[11:8], 1'b0 };
  wire [31:0] imm_U = { IR[31:12], 12'b0 };
  wire [31:0] imm_J = { {12{IR[31]}}, IR[19:12], IR[20], IR[30:25], IR[24:21], 1'b0 };
  wire [31:0] imm_C = { 27'b0, IR[19:15] };
    
  always @(posedge clk) begin
      case (w_opcode)
            `OPCODE_OP_IMM__ : immVal <= imm_I;
            `OPCODE_STORE___ : immVal <= imm_S;
            `OPCODE_LOAD____ : immVal <= imm_I;
            `OPCODE_LUI_____ : immVal <= imm_U;
            `OPCODE_BRANCH__ : immVal <= imm_B;
            `OPCODE_AUIPC___ : immVal <= imm_U;
            `OPCODE_JAL_____ : immVal <= imm_J;
            `OPCODE_JALR____ : immVal <= imm_I;
            `OPCODE_SYSTEM__ : immVal <= imm_C;
            default          : immVal <= 0;
        endcase
    end

  
endmodule
    
    