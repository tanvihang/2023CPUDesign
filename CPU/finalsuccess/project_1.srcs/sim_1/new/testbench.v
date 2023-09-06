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

module testbench(

    );
	
    reg CLOCK_50;
    reg rst;

    //每隔10ns，CLOCK_50信号翻转�?次，�?以一个周期是20ns，对�?50MHz
    initial begin
        CLOCK_50 = 1'b0;
        forever #10 CLOCK_50 = ~CLOCK_50;
    end

    //�?初时刻，复位信号有效，在�?195ns，复位信号无效，�?小SOPC�?始运�?
    //运行1000ns后，暂停仿真
    initial begin
        rst = 1'b1;
        #195 rst = 1'b0;
        #5000 $stop;
    end

    //例化�?小SOPC
    openmips_min_sopc openmips_min_sopc0(
        .clk(CLOCK_50),
        .rst(rst)
    );

endmodule
