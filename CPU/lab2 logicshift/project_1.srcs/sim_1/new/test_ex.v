`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/05 11:48:14
// Design Name: 
// Module Name: test_ex
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


module test_ex(

    );
	
	reg clk;
	reg rst;

	reg [31:0]pc_i = 32'h00000000;
	reg [31:0]inst_i = 32'h34011100; //ori 指令
	
	reg [31:0]reg1_data_i = 32'h00000001;
	reg [31:0]reg2_data_i = 32'h00000001;

	wire reg1_read_o;
	wire reg2_read_o;
	wire [4:0] reg1_addr_o;
	wire [4:0] reg2_addr_o;
	wire [2:0] alusel_o;
	wire [7:0] aluop_o;
	wire [31:0] reg1_o;
	wire [31:0] reg2_o;
	wire [4:0] wd_o;
	wire wreg_o;

	initial begin
		clk = 1'b0;
		
		forever #20 clk = ~clk;

	end
	
	initial begin
		rst = 1'b1;
		#50 rst = 1'b0;
		#1000 $stop;
	end
	
	id id0(
		.rst(rst),
		.pc_i(pc_i),
		.inst_i(inst_i),
		
		.reg1_data_i(reg1_data_i),
		.reg2_data_i(reg2_data_i),
		 
		.reg1_read_o(reg1_read_o),
        .reg2_read_o(reg2_read_o),
		.reg1_addr_o(reg1_addr_o),
		.reg2_addr_o(reg2_addr_o),
		.alusel_o(alusel_o),
		.aluop_o(aluop_o),
		.reg1_o(reg1_o),
		.reg2_o(reg2_o),
		.wd_o(wd_o),       
		.wreg_o(wreg_o)      
	);
	
	wire [2:0] ex_alusel;
	wire [7:0] ex_aluop;
	wire [31:0] ex_reg1;
	wire [31:0] ex_reg2;
	wire [4:0] ex_wd;
	wire ex_wreg;
	
	id_ex id_ex0(
		.clk(clk),
		.rst(rst),
		
		.id_alusel(alusel_o),
		.id_aluop(aluop_o),
		.id_reg1(reg1_o),
		.id_reg2(reg2_o),
		.id_wd(wd_o),
		.id_wreg(wreg_o),
		
		.ex_alusel(ex_alusel),
		.ex_aluop(ex_aluop),
		.ex_reg1(ex_reg1),
		.ex_reg2(ex_reg2),
		.ex_wd(ex_wd),
		.ex_wreg(ex_wreg)
	);
	
	
	wire [4:0]ex_wd_o;
	wire ex_wreg_o;
	wire [31:0]ex_wdata_o;
	
	ex ex0(
		.rst(rst),
		
		.alusel_i(ex_alusel),
		.aluop_i(ex_aluop),
		.reg1_i(ex_reg1),
		.reg2_i(ex_reg2),
		.wd_i(ex_wd),
		.wreg_i(ex_wreg),
		
		.wd_o(ex_wd_o),
		.wreg_o(ex_wreg_o),
		.wdata_o(ex_wdata_o)
	);

endmodule
