module execute_to_memory(clk, rst, flush, instructionIn, PCin, ALUresIn, datain, ALUresOut, dataout, PCout, instruction);
	input clk, rst, flush;
	input [31:0] ALUresIn, instructionIn, datain, PCin;
	output [31:0] ALUresOut, instruction, dataout, PCout;
	
	wire [31:0] PC_inter, inst_inter, data_inter, ALU_inter;
	
	assign PC_inter = flush ? 32'b0 : PCin;
	assign inst_inter = flush ? 32'b0 : instructionIn;
	assign data_inter = flush ? 32'b0 : datain;
	assign ALU_inter = flush ? 32'b0 : ALUresIn;
	
	register instructionreg_EtoM(clk, 1'b1, rst, inst_inter, instruction);
	register ALUres_EtoM(clk, 1'b1, rst, ALU_inter, ALUresOut);
	register data_EtoM(clk, 1'b1, rst, data_inter, dataout);
	register PC_EtoM(clk, 1'b1, rst, PC_inter, PCout);		
	
endmodule

/*
module execute_to_memory (clk, rst, writeback_enable_in, mem_read_enable_in, mem_write_enable_in, PCIn, aluout_in, destination_reg_in, data_in, 
                          writeback_enable,    mem_read_enable,    mem_write_enable,    PC,   aluout,   destination_reg, data_out);
  input clk, rst;
  
  input writeback_enable_in, mem_read_enable_in, mem_write_enable_in;
  input [4:0] destination_reg_in;
  input [31:0] PCIn, aluout_in, data_in;
  
  output reg writeback_enable, mem_read_enable, mem_write_enable;
  output reg [4:0] destination_reg;
  output reg [31:0] PC, aluout, data_out;

  always @ (posedge clk) begin
  
   assign writeback_enable = (rst) ? 0 : writeback_enable_in;
	assign mem_read_enable = (rst) ? 0 : mem_read_enable_in;
	assign mem_write_enable = (rst) ? 0 : mem_write_enable_in;	
	assign aluout = (rst) ? 0 : aluout_in;
	assign PC = (rst) ? 0 : PCIn;
	assign destination_reg = (rst) ? 0 : destination_reg_in;
	assign data_out = (rst) ? 0 : data_in;
	
  end
endmodule 
*/