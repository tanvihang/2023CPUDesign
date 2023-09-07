//全局宏定义
`define RstEnable 1'b1          //复位信号有效
`define RstDisable 1'b0         //复位信号无效
`define ChipEnable 1'b1         //芯片使能
`define ChipDisable 1'b0        //芯片禁止
`define ZeroWord 32'h00000000   //32位的数值0
`define WriteEnable 1'b1        //使能写
`define WriteDisable 1'b0       //禁止写
`define ReadEnable 1'b1         //使能读
`define ReadDisable 1'b0        //禁止读
`define AluSelBus 2:0           //译码阶段的输出alusel_o的宽度
`define AluOpBus 7:0            //译码阶段的输出aluop_o的宽度
`define InstValid 1'b1          //指令有效
`define InstInvalid 1'b0        //指令无效
`define Stop        1'b1        //流水线暂停
`define NoStop      1'b0        //流水线继续
`define Branch 1'b1				//发生转移
`define NotBranch 1'b0			//不发生转移
`define InDelaySlot 1'b1        //是延迟槽指令
`define NotInDelaySlot 1'b0     //不是延迟槽指令

//与指令存储器相关的定义
`define InstAddrBus     31:0    //ROM的地址总线宽度
`define InstBus     31:0        //ROM的数据总线宽度
`define InstMemNum 131071       //ROM的实际大小为128KB
`define InstMemNumLog2  17      //ROM实际使用的地址线宽度

//与通用寄存器Regfile有关的宏定义
`define RegAddrBus 4:0          //Regfile模块的地址线宽度
`define RegBus 31:0             //Regfile模块的数据线宽度
`define DoubleRegBus 63:0       //用于临时存放乘法结果
`define RegNum 32               //通用寄存器的数量
`define RegNumLog2 5            //寻址通用寄存器所用的地址位数
`define NOPRegAddr  5'b00000

//与RAM有关的宏定义
`define DataAddrBus 31:0        //ram地址总线宽度
`define DataBus     31:0        //ram数据总线宽度
`define DataMemNum  131071      //ram的大小，单位是字，即128K word
`define DataMemNumLog2 17       //实际使用的地址宽度
`define ByteWidth   7:0         //一个字节的宽度，8bit 

//与具体指令相关的宏定义
`define EXE_AND     6'b100100   //and指令的功能码
`define EXE_OR      6'b100101   //or指令的功能码
`define EXE_XOR     6'b100110   //xor指令的功能码
`define EXE_NOR     6'b100111   //nor指令的功能码
`define EXE_ANDI    6'b001100   //andi指令的指令码
`define EXE_ORI     6'b001101   //ori指令的指令码
`define EXE_XORI    6'b001110   //xori指令的指令码
`define EXE_LUI     6'b001111   //lui指令的指令码
`define EXE_NOP     6'b000000

`define EXE_SLL     6'b000000   //sll指令的功能码
`define EXE_SRL     6'b000010   //srl指令的功能码
`define EXE_SRA     6'b000011   //sra指令的功能码

`define EXE_SYNC    6'b001111   //sync指令的功能码
`define EXE_PREF    6'b110011   //pref指令的指令码
`define EXE_SPECIAL_INST    6'b000000   //SPECIAL类指令的指令码

//ARITHMETIC EXE
`define EXE_SLT  6'b101010		//指令SLT的功能码
`define EXE_SLTU  6'b101011		//指令SLTU的功能码
`define EXE_SLTI  6'b001010		//指令SLTI的指令码
`define EXE_SLTIU  6'b001011   	//指令SLTIU的指令码
`define EXE_ADD  6'b100000		//指令ADD的功能码
`define EXE_ADDU  6'b100001		//指令ADDU的功能码
`define EXE_SUB  6'b100010		//指令SUB的功能码
`define EXE_SUBU  6'b100011		//指令SUBU的功能码
`define EXE_ADDI  6'b001000		//指令ADDI的指令码
`define EXE_ADDIU  6'b001001	//指令ADDIU的指令码

`define EXE_J  6'b000010		//指令J的功能码
`define EXE_JAL  6'b000011		//指令JAL的功能码
`define EXE_JR  6'b001000		//指令JR的功能码
`define EXE_BEQ  6'b000100		//指令BEQ的指令码

`define EXE_REGIMM_INST 6'b000001	//REGIMM类的指令码

//AluOp
`define EXE_AND_OP      8'b00100100
`define EXE_OR_OP       8'b00100101
`define EXE_XOR_OP      8'b00100110
`define EXE_NOR_OP      8'b00100111
`define EXE_ANDI_OP     8'b01011001
`define EXE_ORI_OP      8'b01011010
`define EXE_XORI_OP     8'b01011011
`define EXE_LUI_OP      8'b01011100   

`define EXE_SLL_OP      8'b01111100
`define EXE_SRL_OP      8'b00000010
`define EXE_SRA_OP      8'b00000011

`define EXE_NOP_OP      8'b00000000

//ARITHMETIC OP
`define EXE_SLT_OP  8'b00101010
`define EXE_SLTU_OP  8'b00101011
`define EXE_SLTI_OP  8'b01010111
`define EXE_SLTIU_OP  8'b01011000   
`define EXE_ADD_OP  8'b00100000
`define EXE_ADDU_OP  8'b00100001
`define EXE_SUB_OP  8'b00100010
`define EXE_SUBU_OP  8'b00100011
`define EXE_ADDI_OP  8'b01010101
`define EXE_ADDIU_OP  8'b01010110

`define EXE_J_OP  8'b01001111
`define EXE_JAL_OP  8'b01010000
`define EXE_JR_OP  8'b00001000
`define EXE_BEQ_OP  8'b01010001

//AluSel
`define EXE_RES_LOGIC   3'b001
`define EXE_RES_SHIFT   3'b010
`define EXE_RES_MOVE    3'b011
`define EXE_RES_NOP     3'b000
`define EXE_RES_ARITHMETIC 3'b100
`define EXE_RES_JUMP_BRANCH 3'b101
`define EXE_RES_LOAD_STORE 3'b110

//Load & Store
`define EXE_LW  6'b100011
`define EXE_SW  6'b101011


`define EXE_LW_OP  8'b11100011
`define EXE_SW_OP  8'b11101011