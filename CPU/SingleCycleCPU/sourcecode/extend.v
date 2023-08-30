`timescale 1ns / 1ps
`include "instruction_head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 13:21:26
// Design Name: 
// Module Name: extend
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


module extend(
		input wire[15:0]                 imm16,     // 16 bit immediate
		input wire[`EXT_OP_LENGTH - 1:0] ext_op,    // ExtOp control signal

		output wire[31:0]                 ext_out    // Extend module output
    );

	//`define EXT_OP_DEFAULT  3'b000      // ExtOp default value
	//`define EXT_OP_SFT16    3'b001      // LUI: Shift Left 16
	//`define EXT_OP_SIGNED   3'b010      // ADDIU: `imm16` signed extended to 32 bit
	//`define EXT_OP_UNSIGNED 3'b011      // LW, SW, ADDI, ORI : `imm16` unsigned extended to 32 bit
	
	assign ext_out =
		(ext_op == `EXT_OP_SFT16) ? {imm16, 16'b0} :
		(ext_op == `EXT_OP_SIGNED) ? {{16{imm16[15]}}, imm16} :
		{16'b0, imm16};
endmodule
