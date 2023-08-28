// Instruction Control signals
// Define: 
//R-Type: ADD, ADDU, SUB, SUBU, AND, OR, SLT, SLL, SRL, XOR
//I-Type: ADDI, ADDIU, ORI, LUI，SW, LW, BEQ  
//J-Type: J, JAL

// Instruction Memory Capacity
`define IM_LENGTH       1023
// Data Memory Capacity
`define DM_LENGTH       1023
// Default register data (32 digits of 0)
`define INITIAL_VAL     32'h00000000

// R-Type instructions
`define INST_R_TYPE     6'b000000  // R-Type opcode, decode via function code
`define FUNC_ADD        6'b100000  // ADD func code
`define FUNC_ADDU       6'b100001  // ADDU func code
`define FUNC_SUB        6'b100010  // SUB func code
`define FUNC_SUBU       6'b100010  // SUBU func code
`define FUNC_AND        6'b100100  // ADD func code
`define FUNC_OR         6'b100101  // OR func code
`define FUNC_XOR        6'b100110  // XOR func code
`define FUNC_SLT        6'b101010  // SLT func code
`define FUNC_SLL        6'b000000  // SLL func code
`define FUNC_SRL        6'b000010  // SRL func code

// I-Type instructions
`define INST_ADDI       6'b001000  // ADDI
`define INST_ADDIU      6'b001001  // ADDIU
`define INST_ORI        6'b001101  // ORI
`define INST_LUI        6'b001111  // LUI
`define INST_SW         6'b101011  // SW
`define INST_LW         6'b100011  // LW
`define INST_BEQ        6'b000100  // BEQ

// J-Type instructions
`define INST_J          6'b000010  // J
`define INST_JAL        6'b000011  // JAL 

// ALU Control Signals
`define ALU_OP_LENGTH   4           // Bits of signal ALUOp
`define ALU_OP_DEFAULT  4'b0000     // ALUOp default value
`define ALU_OP_ADD      4'b0001     // ALUOp ADD
`define ALU_OP_SUB      4'b0010     // ALUOp SUB
`define ALU_OP_AND      4'b0011     // ALUOp AND
`define ALU_OP_OR       4'b0100     // ALUOp OR 
`define ALU_OP_XOR      4'b0101     // ALUOp XOR
`define ALU_OP_SLL      4'b0110     // ALUOp SLL
`define ALU_OP_SRL      4'b0111     // ALUOp SRL
`define ALU_OP_SLT      4'b1000     // ALUOp SLT

// RegDst Control Signals
`define REG_DST_RT      1'b0       // Register write destination: rt
`define REG_DST_RD      1'b1       // Register write destination: rd

// ALUSrc Control Signals
`define ALU_SRC_REG     1'b0       // ALU source: register file
`define ALU_SRC_IMM     1'b1       // ALU Source: immediate

// RegSrc Control Signals
`define REG_SRC_LENGTH  2          // Bits of signal RegSrc
`define REG_SRC_DEFAULT 2'b00      // Register default value
`define REG_SRC_ALU     2'b01      // Register write source: ALU
`define REG_SRC_MEM     2'b10      // Register write source: Data Memory
`define REG_SRC_IMM     2'b11      // Register write source: Extended immediate

// ExtOp Control Signals
`define EXT_OP_LENGTH   3           // Bits of Signal ExtOp
`define EXT_OP_DEFAULT  3'b000      // ExtOp default value
`define EXT_OP_SFT16    3'b001      // LUI: Shift Left 16
`define EXT_OP_SIGNED   3'b010      // ADDIU: `imm16` signed extended to 32 bit
`define EXT_OP_UNSIGNED 3'b011      // LW, SW, ADDI, ORI : `imm16` unsigned extended to 32 bit
`define EXT_OP_GET6_10  3'b100      // SLL,SRL: `imm(10:6)` 

// NPCOp Control Signals
`define NPC_OP_LENGTH   3          // Bits of NPCOp
`define NPC_OP_DEFAULT  3'b000     // NPCOp default value
`define NPC_OP_NEXT     3'b001     // Next instruction: normal
`define NPC_OP_JUMP     3'b010     // Next instruction: J
`define NPC_OP_JAL      3'b011     // Next unstruction: JAL
`define NPC_OP_OFFSET   3'b100     // Next instruction: BEQ