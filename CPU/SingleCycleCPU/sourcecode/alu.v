`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 10:58:56
// Design Name: 
// Module Name: alu
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

`include "instruction_head.v"

module alu(
           input wire[`ALU_OP_LENGTH - 1:0] alu_op,      // ALU Operator signal
           input wire[31:0]                 alu_input1,  // ALU first input
           input wire[31:0]                 alu_input2,  // ALU second input
           input wire[4:0]                  sa,          // Shift operation operand

           output wire[31:0]                alu_result  // ALU result
    );
	
	reg[32:0] alu_reg;

	assign alu_result = alu_reg[31:0];

	// Check whether ALU result is zero
	assign zero       = (alu_reg == 0) ? 1'b1 : 1'b0;

	// displacement defined by sa or rs
	wire[4:0] displacement;
	assign displacement =
		   (alu_op == `ALU_OP_SLL ||
			alu_op == `ALU_OP_SRL) ? sa : alu_input1[4:0];

	// compare rs and rt
	wire[31:0] diff;
	assign diff = (alu_input1 < alu_input2) ? 32'h00000001 : 32'h00000000;

	always @ (*) begin
		case (alu_op)
			`ALU_OP_ADD: // +
				alu_reg <= {alu_input1[31], alu_input1} + {alu_input2[31], alu_input2};
			`ALU_OP_SUB: // -
				alu_reg <= {alu_input1[31], alu_input1} - {alu_input2[31], alu_input2};
			`ALU_OP_AND: // &
				alu_reg <= {alu_input1[31],alu_input1} & {alu_input2[31], alu_input2};
			`ALU_OP_OR: // |
				alu_reg <= {alu_input1[31],alu_input1} | {alu_input2[31], alu_input2};
			`ALU_OP_XOR: // xor
				alu_reg <= {alu_input1[31],alu_input1} ^ {alu_input2[31], alu_input2};
			`ALU_OP_SLL:
				alu_reg <= {alu_input2[31], alu_input2} << displacement;
			`ALU_OP_SRL:
				alu_reg <= {alu_input2[31], alu_input2} >> displacement;
			`ALU_OP_SLT:
				alu_reg <= diff;
			default:
				alu_reg <= {alu_input2[31], alu_input2};
		endcase
	end
	
endmodule
