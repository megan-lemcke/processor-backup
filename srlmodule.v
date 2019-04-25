module srlmodule(data_operandA, ctrl_shiftamt, data_result);

	input [31:0] data_operandA;
	input [4:0] ctrl_shiftamt;
	
	output [31:0] data_result;
	
	wire [31:0] shifted1, shifted2, shifted4, shifted8, shifted16;
	
	wire [31:0] output1, output2, output3, output4;
	
	wire signbit;
	
	assign signbit = data_operandA[31];
	
	assign shifted1[30:0] = data_operandA[31:1];
	assign shifted1[31] = signbit;
	
	assign shifted2[29:0] = output1[31:2];
	assign shifted2[31] = signbit;
	assign shifted2[30] = signbit;
	
	assign shifted4[27:0] = output2[31:4];
	assign shifted4[31] = signbit;
	assign shifted4[30] = signbit;
	assign shifted4[29] = signbit;
	assign shifted4[28] = signbit;
	
	assign shifted8[23:0] = output3[31:8];
	assign shifted8[31] = signbit;
	assign shifted8[30] = signbit;
	assign shifted8[29] = signbit;
	assign shifted8[28] = signbit;
	assign shifted8[27] = signbit;
	assign shifted8[26] = signbit;
	assign shifted8[25] = signbit;
	assign shifted8[24] = signbit;
	
	assign shifted16[15:0] = output4[31:16];
	assign shifted16[31] = signbit;
	assign shifted16[30] = signbit;
	assign shifted16[29] = signbit;
	assign shifted16[28] = signbit;
	assign shifted16[27] = signbit;
	assign shifted16[26] = signbit;
	assign shifted16[25] = signbit;
	assign shifted16[24] = signbit;
	assign shifted16[23] = signbit;
	assign shifted16[22] = signbit;
	assign shifted16[21] = signbit;
	assign shifted16[20] = signbit;
	assign shifted16[19] = signbit;
	assign shifted16[18] = signbit;
	assign shifted16[17] = signbit;
	assign shifted16[16] = signbit;
	
	mux_2 mux1(ctrl_shiftamt[0], data_operandA, shifted1, output1);
	mux_2 mux2(ctrl_shiftamt[1], output1, shifted2, output2);
	mux_2 mux3(ctrl_shiftamt[2], output2, shifted4, output3);
	mux_2 mux4(ctrl_shiftamt[3], output3, shifted8, output4);
	mux_2 mux5(ctrl_shiftamt[4], output4, shifted16, data_result);
	

endmodule
