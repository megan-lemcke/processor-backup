module writeback (memoryReadEnable, instruction, PC, memoryData, aluout, writeback_result, ctrl_writeReg);
  input memoryReadEnable;
  input [31:0] memoryData, aluout, instruction, PC;
  output [31:0] writeback_result;
  output [4:0] ctrl_writeReg;
  
  wire [31:0] writeback_result_inter, PCplus1;
  
  addmodule_all32 PC_plus1 (
    .data_operandA(32'd1),
    .data_operandB(PC),
	 .cin(1'b0),
    .data_result(PCplus1)
  );

  assign writeback_result_inter = (memoryReadEnable) ? memoryData : aluout;
  assign writeback_result = jal ? (PCplus1) : (writeback_result_inter);
	
  and i_am_a_jal(jal, ~instruction[31], ~instruction[30], ~instruction[29], instruction[28], instruction[27]);
  
  assign ctrl_writeReg = jal ? (5'd31) : (instruction[26:22]);
  
  
endmodule 