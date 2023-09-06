`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/04 15:53:57
// Design Name: 
// Module Name: regfile
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

module regfile(
    input wire                clk,
    input wire                rst,

    //写端口
    input wire we,
    input wire[`RegAddrBus]   waddr,
    input wire[`RegBus]       wdata,

    //读端口1
    input wire                re1,
    input wire[`RegAddrBus]   raddr1,
    output reg[`RegBus]       rdata1,

    //读端口2
    input wire                re2,
    input wire[`RegAddrBus]   raddr2,
    output reg[`RegBus]       rdata2
);

//定义32个位宽为32的通用寄存器
reg [`RegBus] regs[0:`RegNum-1];

//写操作
always @(posedge clk) begin
    if(rst == `RstDisable) begin
      if((we == `WriteEnable) && (waddr != `RegNumLog2'h0)) begin   //寄存器0不可写
        regs[waddr] <= wdata;
      end
    end
end
//MIPS32架构规定$0的值只能为0

//读操作1,组合逻辑
always @(*) begin
    if(rst == `RstEnable) begin
      rdata1 <= `ZeroWord;
    end
    else if(raddr1 == `RegNumLog2'h0) begin
      rdata1 <= `ZeroWord;
    end
    else if((re1 == `ReadEnable) && (we == `WriteEnable) && (waddr == raddr1)) begin
      rdata1 <= wdata;
    end
    else if(re1 == `ReadEnable) begin
      rdata1 <= regs[raddr1];
    end
    else begin
      rdata1 <= `ZeroWord;
    end
end

//读操作2
always @(*) begin
    if(rst == `RstEnable) begin
      rdata2 <= `ZeroWord;
    end
    else if(raddr2 == `RegNumLog2'h0) begin
      rdata2 <= `ZeroWord;
    end
    else if((re2 == `ReadEnable) && (we == `WriteEnable) && (waddr == raddr2)) begin
      rdata2 <= wdata;
    end
    else if(re2 == `ReadEnable) begin
      rdata2 <= regs[raddr2];
    end
    else begin
      rdata2 <= `ZeroWord;
    end
end
 
endmodule