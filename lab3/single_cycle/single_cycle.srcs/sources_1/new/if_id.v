`include "defines.v"

module if_id(
    input wire clk,
    input wire rst,
    
    input wire [`InstAddrBus] if_pc,
    input wire [`InstBus] if_inst, //Ö¸Áî

    output reg [`InstAddrBus] id_pc, //Êä³öpc
    output reg [`InstBus] id_inst
);
endmodule
