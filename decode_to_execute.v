module decode_to_execute(clk, rst, enable, flush, PCIn, instructionIn, Jump2in, dataAin, dataBin, PC, instruction, dataA, dataB, Jump2out);
	input clk, rst, flush, Jump2in, enable;
	input [31:0] PCIn, instructionIn;
	input [31:0] dataAin, dataBin;
	output [31:0] PC, instruction, dataA, dataB;
	output Jump2out;
	
	wire [31:0] PC_inter, inst_inter, dataA_inter, dataB_inter;

	assign PC_inter = flush ? 32'b0 : PCIn;
	assign inst_inter = flush ? 32'b0 : instructionIn;
	assign dataA_inter = flush ? 32'b0 : dataAin;
	assign dataB_inter = flush ? 32'b0 : dataBin;
	
	register PCreg_DtoE(clk, enable, rst, PC_inter, PC);
	register instructionreg_DtoE(clk, enable, rst, inst_inter, instruction);
	register dataA_DtoE(clk, enable, rst, dataA_inter, dataA);
	register dataB_DtoE(clk, enable, rst, dataB_inter, dataB);	
	
endmodule


/*
module decode_to_execute(clk, rst, destIn, val1In, val2In, PCIn, register2_in, memoryReadEnable_In, memoryWriteEnable_In, writeback_enable_in,
                         dest,   val1,   val2,   PC,    data, memoryReadEnable,    memoryWriteEnable,    writeback_enable);
  input clk, rst;
  
  input memoryReadEnable_In, memoryWriteEnable_In, writeback_enable_in;
  input [4:0] destIn;
  input [31:0] val1In, val2In, PCIn, register2_in;
  
  output reg memoryReadEnable, memoryWriteEnable, writeback_enable;
  output reg [4:0] dest;
  output reg [31:0] val1, val2, PC, data;

  always @ (posedge clk) begin
	assign memoryReadEnable = (rst) ? 0 : memoryReadEnable_In;
	assign memoryWriteEnable = (rst) ? 0 : memoryWriteEnable_In;
	assign dest = (rst) ? 0 : destIn;
	assign val1 = (rst) ? 0 : val1In;
	assign val2 = (rst) ? 0 : val2In;	
	assign PC = (rst) ? 0 : PCIn;
	assign writeback_enable = (rst) ? 0 : writeback_enable_in;
	assign data = (rst) ? 0 : register2_in;
  end
  
endmodule
*/
