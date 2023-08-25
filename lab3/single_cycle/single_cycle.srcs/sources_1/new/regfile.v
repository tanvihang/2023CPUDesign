`include "defines.v"

//32个寄存器文件
module regfile(
    input wire clk,
    input wire rst,
    
    //读写地址和使能
    
    //写端口
    input wire we,
    input wire [`RegAddrBus] waddr,
    input wire [`RegBus] wdata,
    
    //读端口1
    input wire re1,
    input wire [`RegAddrBus] raddr1,
    input wire [`RegBus] rdata1,
    
    //读端口2
    input wire re2,
    input wire [`RegAddrBus] raddr2,
    input wire [`RegBus] rdata2
);
endmodule