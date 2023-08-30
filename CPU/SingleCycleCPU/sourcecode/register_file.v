`timescale 1ns / 1ps
`include "instruction_head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 13:22:54
// Design Name: 
// Module Name: register_file
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

//寄存器堆
module register_file(
	input wire clk,
	input wire reg_write,
	
	input wire [4:0] read_reg1_addr,
	input wire [4:0] read_reg2_addr,
	input wire [4:0] write_reg_addr,
	input wire [31:0] write_data,
	
	output wire [31:0] reg1_data,
	output wire [31:0] reg2_data,
	
	output wire [7:0] debug_reg_single
    );
	
	//32x32 register
	reg[31:0] gpr[31:0];
	
	assign debug_reg_single = gpr[1][7:0];
	
	//初始化或者赋值
	assign reg1_data = (read_reg1_addr == 0) ? `INITIAL_VAL : gpr[read_reg1_addr];
	assign reg2_data = (read_reg2_addr == 0) ? `INITIAL_VAL : gpr[read_reg2_addr];
	
	//写寄存器，使用时序
	always @(posedge clk) begin
		if(reg_write) begin
			gpr[write_reg_addr] <= write_data;
		end
	end
	
endmodule
