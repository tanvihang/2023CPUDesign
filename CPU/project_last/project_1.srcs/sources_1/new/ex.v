`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/04 16:07:05
// Design Name: 
// Module Name: ex
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

module ex(
    input wire              rst,

    //译码阶段送到执行阶段的信息
    input wire[`AluSelBus]  alusel_i,
    input wire[`AluOpBus]   aluop_i,
    input wire[`RegBus]     reg1_i,
    input wire[`RegBus]     reg2_i,
    input wire[`RegAddrBus] wd_i,
    input wire              wreg_i,
    input wire[`RegBus]     inst_i,//当前处于执行阶段的指令

    //执行的结果
    output reg[`RegAddrBus] wd_o,       //执行阶段的结果最终要写入的目的寄存器的地址
    output reg wreg_o,
    output reg[`RegBus] wdata_o,         //执行阶段最终要写入目的寄存器的值

    
    //加载、存储指令所需的输出接口
    output wire[`AluOpBus]  aluop_o,
    output wire[`RegBus]    mem_addr_o,
    output wire[`RegBus]    reg2_o,

    //处于执行阶段的转移指令要保存的返回地址
    input wire [`RegBus] link_address_i,
    //当前执行阶段的指令是否位于延迟槽
    input wire is_in_delayslot_i
);

    //保存逻辑运算的结果
    reg [`RegBus] logicout;
    //保存移位运算的结果
    reg [`RegBus] shiftres;

    //算术运算所需的变量
    reg[`RegBus] arithmeticres; //保存算术运算结果
    wire ov_sum;				//保存溢出情况
    wire reg1_eq_reg2;			//第一个操作数是否等于第二个操作数
    wire reg1_lt_reg2;			//第一个操作数是否小于第二个操作数
    wire[`RegBus] reg2_i_mux;	//保存输入的第二个操作reg2_i的补码
    wire[`RegBus] reg1_i_not;	//保存输入的第一个操作数reg1_i取反后的值
    wire[`RegBus] result_sum;	//保存加法结果


//计算算术运算相关变量的值
    //如果为减法或有符号比较运算，则reg2应取补码形式，否则取原码
    assign reg2_i_mux = ((aluop_i == `EXE_SUB_OP) || (aluop_i == `EXE_SUBU_OP) ||
                         (aluop_i == `EXE_SLT_OP)) ? (~reg2_i) + 1'b1 : reg2_i;
						 
    //如果是加法运算，则reg2_i_mux=reg2_i，所以result_sum就是加法的结果
    //如果是减法运算，则reg2_i_mux是reg2_i的补码，所以result_sum就是减法的结果
    //如果是有符号比较运算，result_sum就是减法的结果，可由该结果进一步进行大小的判断
    assign result_sum = reg1_i + reg2_i_mux;
	
    //加减法指令执行时，需判断结果是否溢出，两正数相加为负数，两负数相加为正数时均存在溢出
    assign ov_sum = ((reg1_i[31] && reg2_i_mux[31] && (~result_sum[31]))) ||
                    (((~reg1_i[31] && ~reg2_i_mux[31]) && result_sum[31]));
					
    //比较操作数1是否小于操作数2需分有符号比较和无符号比较两种方式
    assign reg1_lt_reg2 = (aluop_i == `EXE_SLT_OP) ? ((reg1_i[31] && ~reg2_i[31]) ||
                          (~reg1_i[31] && ~reg2_i[31] && result_sum[31]) || 
                          (reg1_i[31] && reg2_i[31] && result_sum[31])): (reg1_i < reg2_i);
						  
    //对reg_1逐位取反，赋给reg1_i_not
    assign reg1_i_not = ~reg1_i;
	
	//aluop_o会传递到访存阶段，届时将利用其确定加载、存储类型
    assign aluop_o = aluop_i;
	
	//mem_addr_o会传递到访存阶段，是加载、存储指令对应的存储器地址
    assign mem_addr_o = reg1_i + {{16{inst_i[15]}},inst_i[15:0]};
	
    //reg2_i是存储指令要存储的数据，或lwl、lwr指令要加载到目的寄存器的原始值
    //将该值通过reg2_o接口传递到访存阶段
    assign reg2_o = reg2_i;


    //进行逻辑运算
    always @(*) begin
        if(rst == `RstEnable) begin
          logicout = `ZeroWord;
        end
        else begin
            case(aluop_i)
                `EXE_OR_OP:     logicout = reg1_i | reg2_i;
                `EXE_AND_OP:    logicout = reg1_i & reg2_i;
                `EXE_NOR_OP:    logicout = ~(reg1_i | reg2_i);
                `EXE_XOR_OP:    logicout = reg1_i ^ reg2_i;
                default:    logicout = `ZeroWord;
            endcase
        end  
    end

    //进行移位运算
    always @(*) begin
        if(rst == `RstEnable) begin
          shiftres = `ZeroWord;
        end
        else begin
          case(aluop_i)
            `EXE_SLL_OP:    shiftres = reg2_i << reg1_i[4:0];
            `EXE_SRL_OP:    shiftres = reg2_i >> reg1_i[4:0];
            `EXE_SRA_OP:begin
              shiftres = ({32{reg2_i[31]}}<<(6'd32-{1'b0,reg1_i[4:0]})) | (reg2_i >> reg1_i[4:0]);
            end
            default:        shiftres = `ZeroWord;
          endcase
        end
    end

    //进行算术运算
    always @(*) begin
        if(rst == `RstEnable) begin
            arithmeticres = `ZeroWord;
        end
        else begin
            case(aluop_i)
                `EXE_SLT_OP,`EXE_SLTU_OP:begin        //比较运算
                    arithmeticres = reg1_lt_reg2;
                end
                `EXE_ADD_OP,`EXE_ADDU_OP,`EXE_ADDI_OP,`EXE_ADDIU_OP:begin //加法运算
                    arithmeticres = result_sum;
                end
                `EXE_SUB_OP,`EXE_SUBU_OP:begin        //减法运算
                    arithmeticres = result_sum;
                end
                default:begin
                    arithmeticres = `ZeroWord;
                end
            endcase
        end
    end

    //根据alusel指示的运算类型，选择一个运算结果作为最终结果
    //此时只有逻辑运算结果
    always @(*) begin
        wd_o = wd_i;
          if(((aluop_i == `EXE_ADD_OP) || (aluop_i == `EXE_ADDI_OP) || 
            (aluop_i == `EXE_SUB_OP)) && (ov_sum == 1'b1))begin
              wreg_o = `WriteDisable;
          end
          else begin
              wreg_o = wreg_i;
          end
        case(alusel_i)
            `EXE_RES_LOGIC:     wdata_o = logicout;
            `EXE_RES_SHIFT:     wdata_o = shiftres;
            `EXE_RES_ARITHMETIC:wdata_o = arithmeticres;
            `EXE_RES_JUMP_BRANCH:begin
                wdata_o <= link_address_i;
            end
            default:            wdata_o = `ZeroWord;
        endcase
    end

endmodule