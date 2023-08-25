`include "defines.v"

module mem_wb(
    input wire clk,
    input wire rst,
    
    input wire[`RegAddrBus] mem_wd,
    input wire[`RegBus] mem_wdata,
    input wire mem_wreg,
    
    //output to wb
    output reg[`RegAddrBus] wb_wd,
    output reg[`RegBus] wb_wdata,
    output reg wb_wreg
);
endmodule