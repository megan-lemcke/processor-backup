module sllmodule(data_operandA, ctrl_shiftamt, data_result);

	input [31:0] data_operandA;
	input [4:0] ctrl_shiftamt;
	
	output [31:0] data_result;
	
	wire [31:0] shifted1, shifted2, shifted4, shifted8, shifted16;
	
	wire [31:0] output1, output2, output3, output4;
	
	assign shifted1[31:1] = data_operandA[30:0];
	assign shifted1[0] = 1'b0;
	
	assign shifted2[31:2] = output1[29:0];
	assign shifted2[1:0] = 1'b0;
	
	assign shifted4[31:4] = output2[27:0];
	assign shifted4[3:0] = 1'b0;
	
	assign shifted8[31:8] = output3[23:0];
	assign shifted8[7:0] = 1'b0;
	
	assign shifted16[31:16] = output4[15:0];
	assign shifted16[15:0] = 1'b0;
	
	mux_2 mux1(ctrl_shiftamt[0], data_operandA, shifted1, output1);
	mux_2 mux2(ctrl_shiftamt[1], output1, shifted2, output2);
	mux_2 mux3(ctrl_shiftamt[2], output2, shifted4, output3);
	mux_2 mux4(ctrl_shiftamt[3], output3, shifted8, output4);
	mux_2 mux5(ctrl_shiftamt[4], output4, shifted16, data_result);
	

endmodule
