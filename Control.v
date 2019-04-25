module Control(RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, branch, jumptarget, immed_value, ALUOp, branch1, branch2, AddImmediate, lw, sw, rd_reg, rs_reg, Rtype, Itype, JItype, JIItype, jump, SignZero, instruction);

	output RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,branch,jump,SignZero;
	output [4:0] ALUOp;
	output [4:0] rd_reg, rs_reg;
	output Rtype, Itype, JItype, JIItype;
	output [26:0] jumptarget;
	output [16:0] immed_value;
	input [31:0] instruction;
	
	wire [4:0] opcode;
	assign opcode = instruction[31:27];
	
	wire [4:0] notopcode;
	not not0(notopcode[0], opcode[0]);
	not not1(notopcode[1], opcode[1]);
	not not2(notopcode[2], opcode[2]);
	not not3(notopcode[3], opcode[3]);
	not not4(notopcode[4], opcode[4]);
	
	wire ALUoperation; // opcode = 00000
	and i_am_an_ALUoperation(ALUoperation, notopcode[0], notopcode[1], notopcode[2], notopcode[3], notopcode[4]);
	
	output AddImmediate; // opcode = 00101
	and i_am_an_addimmediate(AddImmediate, opcode[0], notopcode[1], opcode[2], notopcode[3], notopcode[4]);

	wire jump1, jump2, jump3; // opcode = 00001 (j), 00011 (jal), or 00100 (jr)
	and i_am_a_jump1(jump1, opcode[0], notopcode[1], notopcode[2], notopcode[3], notopcode[4]);
	and i_am_a_jump2(jump2, opcode[0], opcode[1], notopcode[2], notopcode[3], notopcode[4]);
	and i_am_a_jump3(jump3, notopcode[0], notopcode[1], opcode[2], notopcode[3], notopcode[4]);
	or i_am_a_jump(jump, jump1, jump2, jump3);
	
	output branch1, branch2;
	wire branch3; // opcode = 00010 (bne), 00110 (blt), 10110 (bex)
	and i_am_a_branch1(branch1, notopcode[0], opcode[1], notopcode[2], notopcode[3], notopcode[4]);
	and i_am_a_branch2(branch2, notopcode[0], opcode[1], opcode[2], notopcode[3], notopcode[4]);
	and i_am_a_branch3(branch3, notopcode[0], opcode[1], opcode[2], notopcode[3], opcode[4]);
	or i_am_a_branch(branch, branch1, branch2, branch3);
	
	wire bex;
	assign bex = branch3;
	
	wire setx; // opcode = 10101
	and i_am_a_setx(setx, opcode[0], notopcode[1], opcode[2], notopcode[3], opcode[4]);
	
	output lw; // opcode = 01000
	and i_am_a_lw(lw, notopcode[0], notopcode[1], notopcode[2], opcode[3], notopcode[4]);
	
	output sw; // opcode = 00111
	and i_am_a_sw(sw, notopcode[4], notopcode[3], opcode[2], opcode[1], opcode[0]);
	
	or registerdestination(RegDst, ALUoperation, AddImmediate);
	
	or ALUSource(ALUSrc, lw, sw, AddImmediate, setx);
	
	assign MemtoReg = lw;
	
	or RegisterWrite(RegWrite, ALUoperation, AddImmediate, jump2, lw, setx);
	
	assign MemRead = lw;
	
	assign MemWrite = sw;
	
	assign ALUOp = instruction[6:2];
	
	wire rd_R_I_JII;
	
	or rdregister(rd_R_I_JII, ALUoperation, AddImmediate, jump3);
	
	assign rd_reg = rd_R_I_JII ? instruction[26:22] : 5'b0;
	
	wire rs_R_I;
	
	or rsregister(rs_R_I, ALUoperation, AddImmediate);
	
	assign rs_reg = rs_R_I ? instruction[21:17] : 5'b0;
	
	//assign rd_reg = ALUoperation ? instruction[26:22] : 5'b0;  // R instruction
	//assign rd_reg = AddImmediate ? instruction[26:22] : 5'b0;  // I instruction
	//assign rd_reg = jump3 ? instruction[26:22] : 5'b0;  // JII instruction
	
	//assign rs_reg = ALUoperation ? instruction[21:17] : 5'b0;  // R instruction
	//assign rs_reg = AddImmediate ? instruction[21:17] : 5'b0;  // I instruction
	
	// TYPE OF INSTRUCTION
	assign Rtype = ALUoperation;
	or itype_or(Itype, lw, sw, branch1, branch2, AddImmediate);
	or jitype_or(JItype, jump1, jump2, bex, setx);
	assign JIItype = jump3;
	//
	
	assign jumptarget = instruction[26:0];
	
	assign immed_value = instruction[16:0];

endmodule 
	