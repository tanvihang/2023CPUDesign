`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/04 23:27:03
// Design Name: 
// Module Name: testbench
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

module testbench(

    );
	
    reg clk;
    reg rst;

    //每隔10ns，CLOCK_50信号翻转一次，所以一个周期是20ns，对应50MHz
    initial begin
        clk = 1'b0;
        forever #10 clk = ~clk;
    end

    //最初时刻，复位信号有效，在第195ns，复位信号无效，最小SOPC开始运行
    //运行1000ns后，暂停仿真
    initial begin
        rst = 1'b1;
        #95 rst = 1'b0;
        #1000 $stop;
    end

    //例化最小SOPC
    openmips_min_sopc openmips_min_sopc0(
        .clk(clk),
        .rst(rst)
    );


	
endmodule
