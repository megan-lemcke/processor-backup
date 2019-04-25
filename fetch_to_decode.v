module fetch_to_decode (clk, rst, enable, flush, PCIn, instructionIn, PC, instruction);
	input clk, rst, flush, enable;
	input [31:0] PCIn, instructionIn;
	output [31:0] PC, instruction;
	
	wire [31:0] PC_inter, inst_inter;
	
	assign PC_inter = flush ? 32'b0 : PCIn;
	assign inst_inter = flush ? 32'b0 : instructionIn;
	
	register PCreg_FtoD(clk, enable, rst, PC_inter, PC);
	register instructionreg_FtoD(clk, enable, rst, inst_inter, instruction);
	
endmodule