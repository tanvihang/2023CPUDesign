`include "defines.v"

//32���Ĵ����ļ�
module regfile(
    input wire clk,
    input wire rst,
    
    //��д��ַ��ʹ��
    
    //д�˿�
    input wire we,
    input wire [`RegAddrBus] waddr,
    input wire [`RegBus] wdata,
    
    //���˿�1
    input wire re1,
    input wire [`RegAddrBus] raddr1,
    input wire [`RegBus] rdata1,
    
    //���˿�2
    input wire re2,
    input wire [`RegAddrBus] raddr2,
    input wire [`RegBus] rdata2
);
endmodule