`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/04 16:22:37
// Design Name: 
// Module Name: openmips_min_sopc
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

module openmips_min_sopc(
    input wire clk,
    input wire rst
);

    //连接指令寄存器
    wire [`InstAddrBus] inst_addr;
    wire [`InstBus] inst;
    wire rom_ce;

    //例化处理器OpenMips
    openmips openmips0(
        .clk(clk),  .rst(rst),
        .rom_data_i(inst),        .rom_addr_o(inst_addr),
        .rom_ce_o(rom_ce)
    );

    //例化指令存储器ROM
    inst_rom inst_rom0(
    .ce(rom_ce),
    .addr(inst_addr),    .inst(inst)
    );
	
endmodule