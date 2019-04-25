module fetch(clk, rst, branchtaken, PCIn, branchimmediate, nextPC);
  input clk, rst, branchtaken;
  input [31:0] PCIn, branchimmediate;
  output [31:0] nextPC;

  wire [31:0] adder_input;

  mux_2 adderInput (
    .in0(32'd1),
    .in1(branchimmediate),			// the stage where assign it is the stage where we will branch aka probably execute.
    .select(branchtaken),
    .out(adder_input)
  );

  wire coutwire;
  
  addmodule_all32 PC_plus1_or_branch (
    .data_operandA(adder_input),
    .data_operandB(PCIn),
	 .cin(1'b0),
    .data_result(nextPC),
	 .cout(coutwire)
  );

endmodule