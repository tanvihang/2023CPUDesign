`define RstEnable 1'b0          //��λʹ��
`define RstDisable 1'b1         //��λ����
`define WriteEnable 1'b1        //дʹ��
`define WriteDisable 1'b0       //д����
`define ReadEnable 1'b1         //��ʹ��
`define ReadDisable 1'b0        //������
`define Branch 1'b1				//����ת��
`define NotBranch 1'b0			//������ת��
`define ZeroWord 32'h00000000   //32λ����0
`define AluOpBus 7:0            //����׶�����������������ݿ��
`define AluSelBus 2:0           //����׶���������������ݿ��
`define InstValid 1'b0
`define InstInvalid 1'b1
`define True_v 1'b1
`define False_b 1'b0
`define ChipEnable 1'b1
`define ChipDisable 1'b0
`define ChipDisable 1'b0

//ָ��
`define EXE_OR   6'b100101      //ָ��ori�Ĺ�����
`define EXE_ORI  6'b001101      //ָ��ori��ָ����
`define EXE_LUI 6'b001111       //ָ��lui��ָ����

`define EXE_ADD  6'b100000		//ָ��ADD�Ĺ�����

`define EXE_J  6'b000010		//ָ��J�Ĺ�����
`define EXE_BEQ  6'b000100		//ָ��BEQ��ָ����

`define EXE_LW  6'b100011		//ָ��LW��ָ����
`define EXE_SW  6'b101011		//ָ��SW��ָ����

`define EXE_NOP 6'b000000  	     //ָ��nop�Ĺ�����

`define EXE_SPECIAL_INST 6'b000000  //special���ָ����

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
`define EXE_RES_LOGIC 3'b001//�߼�������
`define EXE_RES_NOP 3'b000
`define EXE_RES_ARITHMETIC 3'b100
`define EXE_RES_JUMP_BRANCH 3'b110
`define EXE_RES_LOAD_STORE 3'b111

//��Instruction Rom �йص�
`define InstAddrBus 31:0        //ROM�ĵ�ַ���߿��
`define InstBus 31:0            //ROM���������߿��

//��Reg File�йص�
`define RegAddrBus 4:0          //Regfileģ��ĵ�ַ�߿��
`define RegBus 31:0             //Regfileģ��������߿��
`define NOPRegAddr 5'b00000     //�ղ���ʹ�õļĴ�����ַ
`define RegNum 32               //ͨ�üĴ���������
`define RegNumLog2 5            //Ѱַͨ�üĴ���ʹ�õĵ�ַλ��
`define RegWidth 32
`define DoubleRegWidth 64
`define DoubleRegBus 63:0