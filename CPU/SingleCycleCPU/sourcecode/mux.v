`timescale 1ns / 1ps
`include "instruction_head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 11:09:42
// Design Name: 
// Module Name: mux
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

//mux needed 
//1. regdst, 存储地址
//2. alusrc
//3. regsrc

//1. regdst, 存储地址
// RegDst Control Signals
//`define REG_DST_LENGTH  2
//`define REG_DST_DEFAULT 2'b00      // Register write destination: default
//`define REG_DST_RT      2'b01      // Register write destination: rt
//`define REG_DST_RD      2'b10      // Register write destination: rd
//`define REG_DST_REG_31  2'b11      // Register write destination: 31 bit gpr

//`define REG_31_ADDR     5'b11111
module reg_dst_mux(
		input [`REG_DST_LENGTH-1:0] reg_dst,
		input wire[4:0] rt,
		input wire[4:0] rd,
		
		output wire [4:0] mux_out
    );
	
	wire[4:0] reg_31;
	assign reg_31 = `REG_31_ADDR;
	
	assign mux_out = 
		(reg_dst == `REG_DST_RT) ? rt:
		(reg_dst == `REG_DST_RD) ? rd:
		(reg_dst == `REG_DST_REG_31) ? reg_31:
		rt;
	
endmodule


//2. alusrc
//`define ALU_SRC_REG     1'b0       // ALU source: register file
//`define ALU_SRC_IMM     1'b1       // ALU Source: immediate

module alu_src_mux(
	input wire alu_src,
	input wire[31:0] rt,
	input wire[31:0] imm,
	
	output wire[31:0] mux_out
);

	assign mux_out = (alu_src == `ALU_SRC_REG) ? rt : imm;

endmodule

//3. regsrc
// RegSrc Control Signals
//`define REG_SRC_LENGTH  3         // Bits of signal RegSrc
//`define REG_SRC_DEFAULT 3'b000      // Register default value
//`define REG_SRC_ALU     3'b001      // Register write source: ALU
//`define REG_SRC_MEM     3'b010      // Register write source: Data Memory
//`define REG_SRC_IMM     3'b011      // Register write source: Extended immediate
//`define REG_SRC_JMP_DST 3'b100      // Register write source: Jump destination

module reg_src_mux(
	input wire [`REG_SRC_LENGTH - 1 : 0] reg_src,
	input wire [31:0] alu_result,
	input wire [31:0] extend_imm,
	input wire [31:0] read_mem_data,
	input wire [31:0] jmp_dst,
	
	output wire [31:0] mux_out
);

	assign mux_out = 
		(reg_src == `REG_SRC_ALU) ? alu_result :
		(reg_src == `REG_SRC_MEM) ? read_mem_data :
		(reg_src == `REG_SRC_IMM) ? extend_imm:
		(reg_src == `REG_SRC_JMP_DST) ? jmp_dst:
		alu_result;

endmodule

