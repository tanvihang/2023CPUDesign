`timescale 1ns / 1ps
`include "instruction_head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 13:22:20
// Design Name: 
// Module Name: npc
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


module npc(
	input wire [31:0] pc,
	input wire [15:0] imm16,
	input wire [25:0] imm26,
	input wire [31:0] reg1_data,
	
	input wire [`NPC_OP_LENGTH - 1 : 0] npc_op,
	
	output wire [31:0] npc,
	output wire [31:0] jmp_dst
    );
	
	wire[31:0] pc_4;
	assign pc_4 = pc + 32'h4;
	
	assign jmp_dst = pc + 32'h8;

//`define NPC_OP_LENGTH   3          // Bits of NPCOp
//`define NPC_OP_DEFAULT  3'b000     // NPCOp default value
//`define NPC_OP_NEXT     3'b001     // Next instruction: normal
//`define NPC_OP_JUMP     3'b010     // Next instruction: J
//`define NPC_OP_JAL      3'b011     // Next unstruction: JAL
//`define NPC_OP_OFFSET   3'b100     // Next instruction: BEQ
	
	assign npc =
		(npc_op == `NPC_OP_NEXT) ? pc_4 :
		(npc_op == `NPC_OP_JUMP) ? {pc[31:28], imm26, 2'b00} : //jump Inst
		(npc_op == `NPC_OP_OFFSET) ? {pc_4 + {14{imm16[15]}},{imm16, 2'b000}} : //beq Inst
		pc_4;
	
endmodule
