`timescale 1ns / 1ps
`include "instruction_head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 13:21:12
// Design Name: 
// Module Name: data_memory
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


module data_memory(
			input wire        clk,
			input wire        mem_write,      // Data memory write signal: MemWrite

			input wire[11:2]  mem_addr,       // Data memory target address
			input wire[31:0]  write_mem_data, // Data: write to data memory

			output wire[31:0] read_mem_data   // Data: read from data memory
    );

// Data Memory Storage
reg[31:0] dm[`DM_LENGTH:0];
//initial begin
//$readmemh("./testData.txt",dm);
//end

assign read_mem_data = dm[mem_addr];

always @ (posedge clk) begin
    if (mem_write) begin
        dm[mem_addr] <= write_mem_data;
    end
end

endmodule
