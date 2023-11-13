//**************************************************************************************************/
/**** OPCODE                                                                                   ****/
/**************************************************************************************************/

`define OPCODE_OP______ 7'h33
`define OPCODE_OP_FP___ 7'h53
`define OPCODE_AMO_____ 7'h2F
`define OPCODE_OP_IMM__ 7'h13
`define OPCODE_LOAD____ 7'h03
`define OPCODE_LOAD_FP_ 7'h07
//`define OPCODE_JALR____ 7'h67
`define OPCODE_STORE___ 7'h23
`define OPCODE_STORE_FP 7'h27
`define OPCODE_BRANCH__ 7'h63
`define OPCODE_LUI_____ 7'h37
`define OPCODE_AUIPC___ 7'h17
`define OPCODE_JAL_____ 7'h6F
`define OPCODE_JALR____ 7'h67
`define OPCODE_MADD____ 7'h43
`define OPCODE_MSUB____ 7'h47
`define OPCODE_NMADD___ 7'h4F
`define OPCODE_NMSUB___ 7'h4B
`define OPCODE_MISC_MEM 7'h0F
`define OPCODE_SYSTEM__ 7'h73
`define OPCODE_NOP_____ 7'h13

//special
`define OPCODE_HALT____ 7'h7F

/**************************************************************************************************/
/**** FUNCT                                                                                    ****/
/**************************************************************************************************/

// OP_I
`define FUNCT3_ADD___ 3'h0
`define FUNCT3_SLL___ 3'h1
`define FUNCT3_SLT___ 3'h2
`define FUNCT3_SLTU__ 3'h3
`define FUNCT3_XOR___ 3'h4
`define FUNCT3_SRL___ 3'h5
`define FUNCT3_OR____ 3'h6
`define FUNCT3_AND___ 3'h7

// BRANCH
`define FUNCT3_BEQ___ 3'h0
`define FUNCT3_BNE___ 3'h1
`define FUNCT3_BLT___ 3'h4
`define FUNCT3_BGE___ 3'h5
`define FUNCT3_BLTU__ 3'h6
`define FUNCT3_BGEU__ 3'h7
