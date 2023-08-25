`include "defines.v"

module mem(
    input wire rst,
    
    //from ex_mem
    input wire[`RegAddrBus] wd_i,
    input wire[`RegBus] wdata_i,
    input wire wreg_i,
    
    //after mem
    output reg[`RegAddrBus] wd_o,
    output reg[`RegBus] wdata_o,
    output reg wreg_o
);
endmodule