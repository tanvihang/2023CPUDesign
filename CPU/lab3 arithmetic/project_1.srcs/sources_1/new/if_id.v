`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/04 15:51:39
// Design Name: 
// Module Name: if_id
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

`include "defines.v"

module if_id(
    input wire              rst,
    input wire              clk,

    //来自取值阶段的信号，InstBus表示指令宽度为32
    input wire [`InstBus]   if_inst,
	input wire [`InstAddrBus] if_pc,

    //对应的译码阶段的信号
    output reg [`InstBus]   id_inst,
	output reg [`InstAddrBus] id_pc
);

    always @(posedge clk) begin
        if(rst == `RstEnable) begin
          id_pc <= `ZeroWord;
		  id_inst <= `ZeroWord;
		  
        end
        else begin
          id_inst <= if_inst;
		  id_pc <= if_pc;
        end
    end

endmodule