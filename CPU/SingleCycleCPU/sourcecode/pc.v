`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 13:22:41
// Design Name: 
// Module Name: pc
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

module pc(
	input wire clk,
	input wire rst,
	input wire[31:0] npc,
	
	output reg[31:0] pc
    );
	
	always @(posedge clk) begin
		if(rst) begin
			pc <= `INITIAL_VAL;
		end
		else begin
			pc <= npc;
		end
	end
endmodule
