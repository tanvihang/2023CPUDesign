
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 13:20:53
// Design Name: 
// Module Name: control_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "instruction_head.v"

module control_unit(
	input wire[5:0] opcode,
	input wire[4:0] sa,
	input wire [5:0] func,
	input wire zero, //for beq instruction
	
	//输出的控制信号
	output wire [`ALU_OP_LENGTH-1 : 0] alu_op,
	output wire reg_dst,
	output wire reg_write,
	output wire alu_src,
	output wire mem_write,
	output wire[`REG_SRC_LENGTH - 1 : 0] reg_src,
	output wire[`EXT_OP_LENGTH - 1 : 0] ext_op,
	output wire[`NPC_OP_LENGTH - 1 : 0] npc_op,
	output wire en_lw
    );
	
	//R-Type: ADD, ADDU, SUB, SUBU, AND, OR, SLT, SLL, SRL, XOR
	//I-Type: ADDI, ADDIU, ORI, LUI，SW, LW, BEQ  
	//J-Type: J, JAL
	
	wire type_r, inst_add, inst_addu, inst_sub, inst_subu, inst_and, inst_or, inst_slt, inst_sll, inst_srl, inst_xor;
	wire inst_addi, inst_addiu, inst_ori, inst_lui, inst_sw, inst_lw, inst_beq; 
	wire inst_j, inst_jal;
	
	assign type_r    = (opcode == `INST_R_TYPE)       ? 1 : 0;
	
	// R-Type instructions
	assign inst_add       = (type_r && func == `FUNC_ADD)  ? 1 : 0;
	assign inst_addu       = (type_r && func == `FUNC_ADDU)  ? 1 : 0;
	assign inst_sub      = (type_r && func == `FUNC_SUB) ? 1 : 0;
	assign inst_subu      = (type_r && func == `FUNC_SUBU) ? 1 : 0;
	assign inst_and     = (type_r && func == `FUNC_AND) ? 1 : 0;
	assign inst_or    = (type_r && func == `FUNC_OR) ? 1 : 0;
	assign inst_xor      = (type_r && func == `FUNC_XOR) ? 1 : 0;
	assign inst_slt     = (type_r && func == `FUNC_SLT) ? 1 : 0;
	assign inst_sll      = (type_r && func == `FUNC_SLL) ? 1 : 0;
	assign inst_srl      = (type_r && func == `FUNC_SRL) ? 1 : 0;
	
	// I-Type Instructions
	assign inst_addi      = (opcode == `INST_ADDI)         ? 1 : 0;
	assign inst_addiu     = (opcode == `INST_ADDIU)        ? 1 : 0;
	assign inst_ori     	 = (opcode == `INST_ORI)          ? 1 : 0;
	assign inst_lui       = (opcode == `INST_LUI)          ? 1 : 0;
	assign inst_sw        = (opcode == `INST_SW)           ? 1 : 0;
	assign inst_lw        = (opcode == `INST_LW)           ? 1 : 0;
	assign inst_beq       = (opcode == `INST_BEQ)          ? 1 : 0;
	
	// J-Type Instructions
	assign inst_j         = (opcode == `INST_J)            ? 1 : 0;
	assign inst_jal         = (opcode == `INST_JAL)        ? 1 : 0;
	
	// 允许读存储
	assign en_lw = inst_lw ? 1:0;
	
	//决定op控制信号
	assign alu_op    = 
	   (inst_add || inst_addu || inst_addi || inst_addiu || inst_lw || inst_sw) ? `ALU_OP_ADD : // Add
       (inst_sub || inst_subu || inst_beq || inst_slt) ? `ALU_OP_SUB :                          // Sub
	   (inst_slt) ? `ALU_OP_SLT:																// Slt
	   (inst_or || inst_ori) ? `ALU_OP_OR:														// Or
	   (inst_and) ? `ALU_OP_AND:																// And
	   (inst_xor) ? `ALU_OP_XOR:																// Xor
	   (inst_sll) ? `ALU_OP_SLL:																// Sll
	   (inst_srl) ? `ALU_OP_SRL:																// Srl
       `ALU_OP_DEFAULT;                                       // Default ALU operand (lw,sw,lui,output the second ALU input)
	   
	//决定写寄存器地点（rd, rt和 reg31）
	assign reg_dst = 
	(inst_add || inst_sub || inst_and || inst_or || inst_slt || inst_addu || inst_subu || inst_xor || inst_sll || inst_srl) ? `REG_DST_RD:
	(inst_lui || inst_addi || inst_addiu || inst_ori || inst_lw) ? `REG_DST_RT:
	(inst_jal) ? `REG_DST_REG_31 : `REG_DST_DEFAULT; 			//（sw, beq）

	//assign alu_src1 = (inst_srl || inst_sll ) ? 1:0; //这个再别人代码没有

	assign alu_src = (inst_lw || inst_addi || inst_addiu || inst_ori || inst_sw ) ? 1:0; //这边注意注意一下

	//是否允许写寄存器（除了：SW,J,BEQ）
	assign reg_write = (type_r || inst_add || inst_sub || inst_and || inst_or || inst_slt || inst_addu || inst_xor || inst_subu || inst_srl || inst_sll || inst_lw || inst_addi || inst_addiu || inst_ori || inst_lui || inst_jal) ? 1:0;

	//是否允许写存储器
	assign mem_write = (inst_sw) ? 1:0;

	//写回的数据
	assign reg_src = 
					(inst_lui) ? `REG_SRC_IMM:
					(inst_add || inst_sub || inst_and || inst_or || inst_slt || inst_addu || inst_xor || inst_srl || inst_sll || inst_addi || inst_addiu || inst_ori || inst_subu) ? `REG_SRC_ALU:
					(inst_lw) ? `REG_SRC_MEM :
					(inst_jal) ? `REG_SRC_JMP_DST: `REG_SRC_DEFAULT;
				
	//扩展
	assign ext_op = (inst_lui) ? `EXT_OP_SFT16:
					(inst_addiu || inst_addi ) ? `EXT_OP_SIGNED:
					(inst_lw || inst_sw || inst_ori) ? `EXT_OP_UNSIGNED:
					`EXT_OP_DEFAULT;
					
	assign npc_op    = (inst_add || inst_sub || inst_and || inst_or || inst_slt || inst_addu || inst_xor || inst_srl || inst_sll || inst_sw || inst_lw || inst_addi || inst_addiu || inst_subu || inst_ori || inst_lui) ? `NPC_OP_NEXT : // NPC: normal - next instruction
	(inst_beq && !zero) ? `NPC_OP_NEXT :                                        // NPC: BEQ - normal - next instruction
	(inst_beq && zero) ? `NPC_OP_OFFSET :                                       // NPC: BEQ - jump to target
	(inst_j || inst_jal) ? `NPC_OP_JUMP : `NPC_OP_DEFAULT;  
	
endmodule
