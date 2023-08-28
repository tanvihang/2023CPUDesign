`timescale 1ns / 1ps
`include "instruction_h.v"

module instruction_m(
        //PC address 
        input wire[31:0] pc_address,
        output wire[31:0] instruction
    );

    // Instruction memory storage
    reg[31:0] im [`IM_LENGTH:0];
    assign instruction = im[pc_address];

endmodule