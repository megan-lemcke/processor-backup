module mux_2(select, in0, in1, out);
	input select;
	input [31:0] in0, in1;
	output [31:0] out;
	assign out = select ? in1 : in0; //in1 if select is true, in0 if select is false
endmodule
