`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/05 10:34:31
// Design Name: 
// Module Name: test_if_id
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


module test_if_id(

    );

	reg clk;
	reg rst;

	reg [31:0]if_inst= 32'h00000001;
	reg [31:0]if_pc = 32'h00000001;
	
	wire [31:0] id_inst;
	wire [31:0] id_pc;

	initial begin
		clk = 1'b0;
		
		forever #20 clk = ~clk;

	end
	
	initial begin
		rst = 1'b1;
		#50 rst = 1'b0;
		#1000 $stop;
	end
	
	if_id if_id0(
		.rst(rst),
		.clk(clk),
		
		.if_inst(if_inst),
		.if_pc(if_pc),
		
		.id_inst(id_inst),
		.id_pc(id_pc)
	);
	
endmodule
