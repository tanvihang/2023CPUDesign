`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/05 13:52:57
// Design Name: 
// Module Name: hilo_reg
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
module hilo_reg(
    input wire rst,clk,we,
    input wire [`RegBus] hi_i,lo_i,
    output reg [`RegBus] hi_o,lo_o
);

    always @(posedge clk) begin
        if(rst == `RstEnable) begin
            hi_o <= `ZeroWord;
            lo_o <= `ZeroWord;
        end
        else begin
            if(we == `WriteEnable) begin
                hi_o <= hi_i;
                lo_o <= lo_i;
            end
        end
    end

endmodule