`timescale 1ns / 1ps
`include "instruction_head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 13:24:03
// Design Name: 
// Module Name: top
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

module top(
	input wire clk,
	input wire rst,
	output wire[7:0] debug_reg_single
    );
	
	//第一阶段：获取指令
	wire [31:0] pc;
	wire [31:0] npc;
	wire [31:0] instruction;
	
	pc MyPC(
		.clk(clk),
		.rst(rst),
		.npc(npc),
		
		.pc(pc)
	);
	
	//instruction_memory MyInstMem(
	//	.pc_address(pc[11:2]),
	//	.instruction(instruction)
	//);
	
	inst_rom MyInstRom(
		.a(pc[11:2]),
		.spo(instruction)
	);

	//以后这边添加缓冲寄存器IF/ID

	//第二阶段：译码阶段，并写控制器
	wire [5:0] opcode;
	wire [5:0] func;
	
	wire [4:0] rs;
	wire [4:0] rt;
	wire [4:0] rd;
	wire [4:0] sa;
	
	wire [15:0] imm16;
	wire [25:0] imm26;
	
	assign opcode = instruction[31:26];
	assign func   = instruction[5:0];
	assign rs     = instruction[25:21];
	assign rt     = instruction[20:16];
	assign rd     = instruction[15:11];
	assign sa     = instruction[10:6];
	assign imm16  = instruction[15:0];
	assign imm26  = instruction[25:0];
	
	//控制信号
	wire[`ALU_OP_LENGTH - 1:0]  cu_alu_op;
	wire[`REG_DST_LENGTH - 1:0] cu_reg_dst;
	wire                        en_reg_write;
	wire                        cu_alu_src;
	wire                        en_mem_write;
	wire[`REG_SRC_LENGTH - 1:0] cu_reg_src;
	wire[`EXT_OP_LENGTH - 1:0]  cu_ext_op;
	wire[`NPC_OP_LENGTH  - 1:0] cu_npc_op;
	wire                        zero;
	wire 						en_lw;

	
	control_unit MyCU(
		.opcode(opcode),
		.sa(sa),
		.func(func),
		.zero(zero),
		
		.alu_op(cu_alu_op),
		.reg_dst(cu_reg_dst),
		.reg_write(en_reg_write),
		.alu_src(cu_alu_src),
		.mem_write(en_mem_write),
		.reg_src(cu_reg_src),
		.ext_op(cu_ext_op),
		.npc_op(cu_npc_op),
		.en_lw(en_lw)
	);
	
	//第三阶段：执行阶段
	//找到存储寄存器的地址 
	//might be rt, rd or $31 depends on cu output
	wire [4:0] reg_dst_out;  //mux reg destination
	wire [31:0] ext_out;     //mux reg extention
	wire [31:0] alu_src_out; //mux reg data source
	
	wire [31:0] alu_result;
	
	wire [31:0] reg1_data;
	wire [31:0] reg2_data;
	
	reg_dst_mux MyRegDstMux(
		.reg_dst(cu_reg_dst),
		.rt(rt),
		.rd(rd),
		
		.mux_out(reg_dst_out)
	);
	
	extend MyExtend(
		.imm16(imm16),
		.ext_op(cu_ext_op),
		
		.ext_out(ext_out)
	);
	
	//读取数据寄存器RegisterDump
	register_file MyRegisterFile(
		.clk(clk),
		.reg_write(en_reg_write),
		.read_reg1_addr(rs),
		.read_reg2_addr(rt),
		.write_reg_addr(reg_dst_out), 
		
		.write_data(reg_src_out), //写回阶段确定的
		
		.reg1_data(reg1_data),
		.reg2_data(reg2_data),
		
		.debug_reg_single(debug_reg_single)
	);
	
	//NPC
	wire [31:0] jmp_dst;
	npc MyNPC(
		.pc(pc),
		.imm16(imm16),
		.imm26(imm26),
		.reg1_data(reg1_data),
		.npc_op(cu_npc_op),
		
		.npc(npc),
		.jmp_dst(jmp_dst)
	);
	
	//决定传给alu的值
	alu_src_mux MyALUSrcMux(
		.alu_src(cu_alu_src),
		.rt(reg2_data),
		.imm(ext_out),
		
		.mux_out(alu_src_out)
	);
	
	//传给alu进行计算
	alu MyALU(
		.alu_op(cu_alu_op),
		.alu_input1(reg1_data),
		.alu_input2(alu_src_out),
		.sa(sa),
		
		.alu_result(alu_result)
	);
	
	//第四阶段：访存阶段
	wire[31:0] read_mem_data;
	//data_memory MyDataMemory(
	//	.clk(clk),
	//	.mem_write(en_mem_write),
	//	.mem_addr(alu_result[11:2]),
	//	.write_mem_data(reg2_data),
	//	
	//	.read_mem_data(read_mem_data)
	//);
	
	data_ram MyDataRam(
		.clk(clk),
		.a(alu_result[11:2]),
		.d(reg2_data),
		.we(en_mem_write),
		.spo(read_mem_data)
	);
	
	//第五阶段：写回阶段
	//找到存储寄存器的值
	wire [31:0] reg_src_out;
	reg_src_mux MyRegSrcMux(
		.reg_src(cu_reg_src),
		
		.alu_result(alu_result),
		.extend_imm(ext_out),
		.read_mem_data(read_mem_data),
		.jmp_dst(jmp_dst),
		
		.mux_out(reg_src_out)
	);	
	
endmodule
