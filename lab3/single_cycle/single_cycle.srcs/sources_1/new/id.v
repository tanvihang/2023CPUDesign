`include "defines.v"

module id(
    input wire rst,
    input wire[`RegAddrBus] pc_i,
    input wire[`RegBus] inst_i,
    
    //read Regfile
    input wire[`RegBus] reg1_data_i,
    input wire[`RegBus] reg2_data_i,
    
    //write Regfile, not at id stage
    output reg reg1_read_o,
    output reg reg2_read_o,
    output reg[`RegAddrBus] reg1_addr_o,
    output reg[`RegAddrBus] reg2_addr_o,
    
    //give value to id_ex stage
    output reg[`AluOpBus] aluop_o, //EXE_ADD_OP  8'b00100000
    output reg[`AluSelBus] alusel_o, //选择器，做哪种alu
    output reg[`RegBus] reg1_o, //输出1
    output reg[`RegBus] reg2_o, //输出2
    output reg[`RegAddrBus] wd_o, //写入寄存器地址
    output reg wreg_o
    );
endmodule
