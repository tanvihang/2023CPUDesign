`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/04 15:49:58
// Design Name: 
// Module Name: pc_reg
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

module pc_reg(
    input wire                clk,
    input wire                rst,
    output reg[`InstAddrBus]  pc,
    output reg                ce
);

    always @(posedge clk) begin
        if(rst == `RstEnable) begin
          ce <= `ChipDisable;   //复位时指令存储器禁用
        end
        else begin
          ce <= `ChipEnable;    //复位结束后使能指令存储器
        end
    end

    always @(posedge clk) begin
        if(ce == `ChipDisable) begin
          pc <= 32'h00000000;   //指令存储器禁用时，PC为0
        end
        else begin
          pc <= pc + 4'h4;      //指令存储器使能时，PC的值每时钟周期加4
        end 
    end

endmodule
