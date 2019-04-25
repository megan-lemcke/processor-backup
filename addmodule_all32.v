module addmodule_all32(data_operandA, data_operandB, cin, data_result, cout);

	input [31:0] data_operandA, data_operandB;
	input cin;
	output [31:0] data_result;
	output cout;
	
	wire cout1, cout2, cout3, cout4;

	addmodule add7to0(data_operandA[7:0], data_operandB[7:0], cin, data_result[7:0], cout1);
	addmodule add15to8(data_operandA[15:8], data_operandB[15:8], cout1, data_result[15:8], cout2);
	addmodule add23to16(data_operandA[23:16], data_operandB[23:16], cout2, data_result[23:16], cout3);
	addmodule add31to24(data_operandA[31:24], data_operandB[31:24], cout3, data_result[31:24], cout4);

	assign cout = cout4;
	
endmodule
