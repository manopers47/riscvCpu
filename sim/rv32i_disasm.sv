// SPDX-License-Identifier: Apache-2.0
// Copyright 2026 Silicon Setu and contributors.
//
// RV32I disassembler for the testbench monitor. Written from the RISC-V
// Unprivileged ISA specification (RV32I base, Zicsr, Zifencei).
// Prints objdump-style text with ABI register names, for example
// "addi    a0, sp, 16" or "lw      t0, -4(s0)". Simulation only.

package rv32i_disasm;

  function automatic string reg_name(logic [4:0] r);
    string names[32] = '{
      "zero", "ra", "sp",  "gp",  "tp", "t0", "t1", "t2",
      "s0",   "s1", "a0",  "a1",  "a2", "a3", "a4", "a5",
      "a6",   "a7", "s2",  "s3",  "s4", "s5", "s6", "s7",
      "s8",   "s9", "s10", "s11", "t3", "t4", "t5", "t6"
    };
    return names[r];
  endfunction

  // Pad the mnemonic so operands line up in the log.
  function automatic string op(string m);
    string s = m;
    while (s.len() < 8) s = {s, " "};
    return s;
  endfunction

  function automatic string disasm(logic [31:0] insn);
    logic [6:0]  opcode = insn[6:0];
    logic [4:0]  rd     = insn[11:7];
    logic [2:0]  funct3 = insn[14:12];
    logic [4:0]  rs1    = insn[19:15];
    logic [4:0]  rs2    = insn[24:20];
    logic [6:0]  funct7 = insn[31:25];
    int          imm_i  = $signed(insn[31:20]);
    int          imm_s  = $signed({insn[31:25], insn[11:7]});
    int          imm_b  = $signed({insn[31], insn[7], insn[30:25], insn[11:8], 1'b0});
    int          imm_j  = $signed({insn[31], insn[19:12], insn[20], insn[30:21], 1'b0});
    logic [19:0] imm_u  = insn[31:12];
    string       m;

    case (opcode)
      7'b0110111: return $sformatf("%s%s, 0x%0h", op("lui"),   reg_name(rd), imm_u);
      7'b0010111: return $sformatf("%s%s, 0x%0h", op("auipc"), reg_name(rd), imm_u);
      7'b1101111: return $sformatf("%s%s, %0d",   op("jal"),   reg_name(rd), imm_j);
      7'b1100111: return $sformatf("%s%s, %0d(%s)", op("jalr"), reg_name(rd), imm_i, reg_name(rs1));

      7'b1100011: begin // branches
        case (funct3)
          3'b000: m = "beq";
          3'b001: m = "bne";
          3'b100: m = "blt";
          3'b101: m = "bge";
          3'b110: m = "bltu";
          3'b111: m = "bgeu";
          default: return "unknown";
        endcase
        return $sformatf("%s%s, %s, %0d", op(m), reg_name(rs1), reg_name(rs2), imm_b);
      end

      7'b0000011: begin // loads
        case (funct3)
          3'b000: m = "lb";
          3'b001: m = "lh";
          3'b010: m = "lw";
          3'b100: m = "lbu";
          3'b101: m = "lhu";
          default: return "unknown";
        endcase
        return $sformatf("%s%s, %0d(%s)", op(m), reg_name(rd), imm_i, reg_name(rs1));
      end

      7'b0100011: begin // stores
        case (funct3)
          3'b000: m = "sb";
          3'b001: m = "sh";
          3'b010: m = "sw";
          default: return "unknown";
        endcase
        return $sformatf("%s%s, %0d(%s)", op(m), reg_name(rs2), imm_s, reg_name(rs1));
      end

      7'b0010011: begin // ALU with immediate
        if (insn == 32'h0000_0013) return "nop";
        case (funct3)
          3'b000: m = "addi";
          3'b010: m = "slti";
          3'b011: m = "sltiu";
          3'b100: m = "xori";
          3'b110: m = "ori";
          3'b111: m = "andi";
          3'b001: return $sformatf("%s%s, %s, %0d", op("slli"), reg_name(rd), reg_name(rs1), rs2);
          3'b101: return $sformatf("%s%s, %s, %0d", op(funct7[5] ? "srai" : "srli"),
                                   reg_name(rd), reg_name(rs1), rs2);
        endcase
        return $sformatf("%s%s, %s, %0d", op(m), reg_name(rd), reg_name(rs1), imm_i);
      end

      7'b0110011: begin // ALU register-register
        case ({funct7, funct3})
          {7'b0000000, 3'b000}: m = "add";
          {7'b0100000, 3'b000}: m = "sub";
          {7'b0000000, 3'b001}: m = "sll";
          {7'b0000000, 3'b010}: m = "slt";
          {7'b0000000, 3'b011}: m = "sltu";
          {7'b0000000, 3'b100}: m = "xor";
          {7'b0000000, 3'b101}: m = "srl";
          {7'b0100000, 3'b101}: m = "sra";
          {7'b0000000, 3'b110}: m = "or";
          {7'b0000000, 3'b111}: m = "and";
          default: return "unknown";
        endcase
        return $sformatf("%s%s, %s, %s", op(m), reg_name(rd), reg_name(rs1), reg_name(rs2));
      end

      7'b0001111: return (funct3 == 3'b001) ? "fence.i" : "fence";

      7'b1110011: begin // system
        case (funct3)
          3'b000: begin
            if (insn == 32'h0000_0073) return "ecall";
            if (insn == 32'h0010_0073) return "ebreak";
            if (insn == 32'h3020_0073) return "mret";
            if (insn == 32'h1050_0073) return "wfi";
            return "unknown";
          end
          3'b001: m = "csrrw";
          3'b010: m = "csrrs";
          3'b011: m = "csrrc";
          3'b101: m = "csrrwi";
          3'b110: m = "csrrsi";
          3'b111: m = "csrrci";
          default: return "unknown";
        endcase
        if (funct3[2])
          return $sformatf("%s%s, 0x%03h, %0d", op(m), reg_name(rd), insn[31:20], rs1);
        return $sformatf("%s%s, 0x%03h, %s", op(m), reg_name(rd), insn[31:20], reg_name(rs1));
      end

      default: return "unknown";
    endcase
  endfunction

endpackage
