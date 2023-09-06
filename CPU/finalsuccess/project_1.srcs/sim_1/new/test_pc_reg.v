`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/05 10:23:37
// Design Name: 
// Module Name: test_pc_reg
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


module test_pc_reg(

    );
	
	reg clk;
	reg rst;
	
	wire [31:0] pc;
	wire ce;
	
	initial begin
		clk = 1'b0;
		forever #10 clk = ~clk;
	end
	
	initial begin
		rst = 1'b1;
		#100 rst = 1'b0;
		#1000 $stop;
	end
	
pc_reg pc_reg0(
	.clk(clk),
	.rst(rst),
	.pc(pc),
	.ce(ce)
);
	
endmodule
