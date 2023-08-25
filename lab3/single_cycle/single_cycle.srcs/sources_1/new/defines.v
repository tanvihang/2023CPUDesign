`define RstEnable 1'b0          //复位使能
`define RstDisable 1'b1         //复位除能
`define WriteEnable 1'b1        //写使能
`define WriteDisable 1'b0       //写除能
`define ReadEnable 1'b1         //读使能
`define ReadDisable 1'b0        //读除能
`define Branch 1'b1				//发生转移
`define NotBranch 1'b0			//不发生转移
`define ZeroWord 32'h00000000   //32位数字0
`define AluOpBus 7:0            //译码阶段输出操作子类型数据宽度
`define AluSelBus 2:0           //译码阶段输出操作类型数据宽度
`define InstValid 1'b0
`define InstInvalid 1'b1
`define True_v 1'b1
`define False_b 1'b0
`define ChipEnable 1'b1
`define ChipDisable 1'b0
`define ChipDisable 1'b0

//指令
`define EXE_OR   6'b100101      //指令ori的功能码
`define EXE_ORI  6'b001101      //指令ori的指令码
`define EXE_LUI 6'b001111       //指令lui的指令码

`define EXE_ADD  6'b100000		//指令ADD的功能码

`define EXE_J  6'b000010		//指令J的功能码
`define EXE_BEQ  6'b000100		//指令BEQ的指令码

`define EXE_LW  6'b100011		//指令LW的指令码
`define EXE_SW  6'b101011		//指令SW的指令码

`define EXE_NOP 6'b000000  	     //指令nop的功能码

`define EXE_SPECIAL_INST 6'b000000  //special类的指令码

//AluOp
`define EXE_OR_OP    8'b00100101
`define EXE_ORI_OP  8'b01011010
`define EXE_LUI_OP  8'b01011100   

`define EXE_NOP_OP 8'b00000000

`define EXE_ADD_OP  8'b00100000
`define EXE_J_OP  8'b01001111
`define EXE_BEQ_OP  8'b01010001

`define EXE_LW_OP  8'b11100011
`define EXE_SW_OP  8'b11101011

//AluSel
`define EXE_RES_LOGIC 3'b001//逻辑运算结果
`define EXE_RES_NOP 3'b000
`define EXE_RES_ARITHMETIC 3'b100
`define EXE_RES_JUMP_BRANCH 3'b110
`define EXE_RES_LOAD_STORE 3'b111

//与Instruction Rom 有关的
`define InstAddrBus 31:0        //ROM的地址总线宽度
`define InstBus 31:0            //ROM的数据总线宽度

//与Reg File有关的
`define RegAddrBus 4:0          //Regfile模块的地址线宽度
`define RegBus 31:0             //Regfile模块的数据线宽度
`define NOPRegAddr 5'b00000     //空操作使用的寄存器地址
`define RegNum 32               //通用寄存器的数量
`define RegNumLog2 5            //寻址通用寄存器使用的地址位数
`define RegWidth 32
`define DoubleRegWidth 64
`define DoubleRegBus 63:0