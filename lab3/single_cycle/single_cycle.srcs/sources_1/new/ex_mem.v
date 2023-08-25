`include "defines.v"

module ex_mem(
    input wire clk,
    input wire rst,
    
    //in from ex
    input wire[`RegBus] ex_wdata,
    input wire[`RegAddrBus] ex_wd,
    input wire ex_wreg,
    
    //out to mem
    output reg[`RegAddrBus] mem_wd,
    output reg[`RegBus] mem_wdata,
    output reg mem_wreg
);
endmodule