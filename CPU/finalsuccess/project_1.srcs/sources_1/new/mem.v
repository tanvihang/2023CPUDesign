`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/04 16:15:57
// Design Name: 
// Module Name: mem
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

module mem(
    input wire                  rst,

    //来自执行阶段的信息
    input wire[`RegAddrBus]     wd_i,
    input wire                  wreg_i,
    input wire[`RegBus]         wdata_i,

    //为实现加载、访存指令而添加
    input wire[`AluOpBus]       aluop_i,
    input wire[`RegBus]         mem_addr_i,
    input wire[`RegBus]         reg2_i,
    input wire[`RegBus]         mem_data_i,


    //为实现加载、访存指令而添加
    output reg[`RegBus]         mem_addr_o,
    output                      mem_we_o,
    output reg [3:0]            mem_sel_o,
    output reg[`RegBus]         mem_data_o,
    output reg                  mem_ce_o,

    //访存阶段的结果
    output reg[`RegAddrBus]     wd_o,
    output reg                  wreg_o,
    output reg[`RegBus]         wdata_o
);
    reg         mem_we;
    assign      mem_we_o = mem_we;

    always @(*) begin
        if(rst == `RstEnable) begin
          wd_o = `NOPRegAddr;
          wreg_o = `WriteDisable;
          wdata_o = `ZeroWord;
          mem_addr_o = `ZeroWord;
          mem_we = `WriteDisable;
          mem_sel_o = 4'b0000;
          mem_data_o = `ZeroWord;
          mem_ce_o = `ChipDisable;
        end
        else begin
          wd_o = wd_i;
          wreg_o = wreg_i;
          wdata_o = wdata_i;
          mem_addr_o = `ZeroWord;
          mem_we = `WriteDisable;
          mem_sel_o = 4'b1111;
          mem_data_o = `ZeroWord;
          mem_ce_o = `ChipDisable;

          case(aluop_i)
              `EXE_LW_OP:begin
                  mem_addr_o = mem_addr_i;
                  mem_we = `WriteDisable;
                  mem_ce_o = `ChipEnable;
                  wdata_o = mem_data_i;
                  mem_sel_o = 4'b1111;
              end
              `EXE_SW_OP:begin
                  mem_addr_o = mem_addr_i;
                  mem_we = `WriteEnable;
                  mem_data_o = reg2_i[31:0];
                  mem_ce_o = `ChipEnable;
                  mem_sel_o = 4'b1111;
              end   
              default:begin
                  //do nothing
              end
          endcase
        end
    end

endmodule