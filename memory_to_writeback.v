module memory_to_writeback (clk, rst, aluin, PCin, dmemin, instructionin, aluout, PCout, dmemout, instructionout);
  input clk, rst;
  input [31:0] aluin, dmemin, instructionin, PCin;
  output [31:0] aluout, dmemout, instructionout, PCout;
  
  register instructionreg_MtoW(clk, 1'b1, rst, instructionin, instructionout);
  register ALUres_MtoW(clk, 1'b1, rst, aluin, aluout);
  register dmem_MtoW(clk, 1'b1, rst, dmemin, dmemout);	
  register PC_MtoW(clk, 1'b1, rst, PCin, PCout);	
  
endmodule 