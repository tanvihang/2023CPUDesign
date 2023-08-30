`timescale 1ns / 1ps
`include "instruction_head.v"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 13:21:59
// Design Name: 
// Module Name: instruction_memory
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

//在testbench的时候读入指令文件，然后写进去先
module instruction_memory(
		input wire[31:0] pc_address,
		output wire[31:0] instruction
    );
	
	// Instruction memory storage
    reg[31:0] im [`IM_LENGTH:0];
	
	//initial begin
	//$readmemh("./testInst.txt", im);
	//end
	
    assign instruction = im[pc_address];
	
endmodule
