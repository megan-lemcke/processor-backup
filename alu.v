module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow, twosout);
	input [31:0] data_operandA, data_operandB;
	input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

	output [31:0] data_result;
	output isNotEqual, isLessThan, overflow;
	
	//for subtraction - make negative: flip bits and make carry in one
	
	//flip, have mux take the add or subtracter
	
	wire [4:0] notout;
	wire [5:0] out;
	
	not not0(notout[0], ctrl_ALUopcode[0]);
	not not1(notout[1], ctrl_ALUopcode[1]);
	not not2(notout[2], ctrl_ALUopcode[2]);
	not not3(notout[3], ctrl_ALUopcode[3]);
	not not4(notout[4], ctrl_ALUopcode[4]);
	
	wire yesadd, yessubtract;
	
	and thisisadd(yesadd, notout[0], notout[1], notout[2], notout[3], notout[4]);
	and thisissubtract(yessubtract, ctrl_ALUopcode[0], notout[1], notout[2], notout[3], notout[4]);
	
	wire [31:0] flippedB;
	
	generate

		genvar c;

		for(c = 0; c < 32; c = c + 1) begin : flipbits
			 not my_not(flippedB[c], data_operandB[c]); 
		end

	endgenerate
	
	wire [31:0] andout, orout, sllout, srlout, addout, subout;
	output [31:0] twosout;
	wire [31:0] w7, w8;
	wire addcout, subcout, twoscout;
	
	andmodule my_and(data_operandA, data_operandB, andout);
	ormodule my_or(data_operandA, data_operandB, orout);
	sllmodule my_sll(data_operandA, ctrl_shiftamt, sllout);
	srlmodule my_srl(data_operandA, ctrl_shiftamt, srlout);
	addmodule_all32 my_add(data_operandA, data_operandB, 1'b0, addout, addcout);
	addmodule_all32 my_subtract(data_operandA, flippedB, 1'b1, subout, subcout);
	
	addmodule_all32 twoscomp(flippedB, 32'h00000001, 1'b0, twosout, twoscout);
	
	
	// isNotEqual
	wire ne1, ne2, ne3, ne4;
	or not_equal_or1(ne1, subout[0], subout[1], subout[2], subout[3], subout[4], subout[5], subout[6], subout[7]);
	or not_equal_or2(ne2, subout[8], subout[9], subout[10], subout[11], subout[12], subout[13], subout[14], subout[15]);
	or not_equal_or3(ne3, subout[16], subout[17], subout[18], subout[19], subout[20], subout[21], subout[22], subout[23]);
	or not_equal_or4(ne4, subout[24], subout[25], subout[26], subout[27], subout[28], subout[29], subout[30], subout[31]);
	
	wire notequal;
	or not_equal_final(notequal, ne1, ne2, ne3, ne4);
	
	assign isNotEqual = notequal;
	
	
	// overflow
	wire addcond1, addcond2, subcond1, subcond2, final;
	wire notone, nottwo, notthree, notfour, nottwoflip;
	
	not notonegate(notone, data_operandA[31]);
	not nottwogate(nottwo, data_operandB[31]);
	and addcondition1(addcond1, yesadd, notone, nottwo, addout[31]);
	
	not notthreegate(notthree, addout[31]);
	and addcondition2(addcond2, yesadd, data_operandA[31], data_operandB[31], notthree);
	
	and subcondition1(subcond1, yessubtract, notone, data_operandB[31], subout[31]);
	//and subcondition1(subcond1, yessubtract, notone, twosout[31], subout[31]);
	not nottwogateflip(nottwoflip, twosout[31]);
	//and subcondition1(subcond1, yessubtract, notone, nottwoflip, subout[31]);
	
	not notfourgate(notfour, subout[31]);
	//not nottwogateflip(nottwoflip, twosout[31]);
	and subcondition2(subcond2, yessubtract, data_operandA[31], nottwo, notfour);
	//and subcondition2(subcond2, yessubtract, data_operandA[31], twosout[31], notfour);
	/*
	wire [30:0] edgewire;
	
	generate

		genvar p;

		for(p = 0; p < 31; p = p + 1) begin : edgecase
			 not edgenot(edgewire[p], data_operandB[p]); 
		end

	endgenerate
	
	wire edgew1, edgew2, edgew3, edgew4, edgefinal;
	
	and e1(edgew1, edgewire[0], edgewire[1], edgewire[2], edgewire[3], edgewire[4], edgewire[5], edgewire[6], edgewire[7]);
	and e2(edgew2, edgewire[8], edgewire[9], edgewire[10], edgewire[11], edgewire[12], edgewire[13], edgewire[14], edgewire[15]);
	and e3(edgew3, edgewire[16], edgewire[17], edgewire[18], edgewire[19], edgewire[20], edgewire[21], edgewire[22], edgewire[23]);
	and e4(edgew4, edgewire[24], edgewire[25], edgewire[26], edgewire[27], edgewire[28], edgewire[29], edgewire[30]);
	and e5(edgefinal, edgew1, edgew2, edgew3, edgew4, data_operand[31]);
	*/
	or overflowor(final, addcond1, addcond2, subcond1, subcond2);
	 
	assign overflow = final;
	
	// isLessThan
	wire msb1;
	assign msb1 = subout[31];
	//wire outofbounds1, notmsb;
	//not oobnot(notmsb, subout[31]);
	//and outofboundsand(outofbounds1, notmsb,subcout);
	//assign outofbounds1 = subcout;
	wire andgate1, andgate2, notoverflow, notmsb1;
	not notoverflowgate(notoverflow, overflow);
	not notmsb(notmsb1, msb1);
	// overflow --> different sign --> B operand [31] == 1
	// same sign --> no overflow, msb
	
	and andgate1g(andgate1, msb1, notoverflow);
	and andgate2g(andgate2, data_operandA[31], overflow);
	
	wire islessthanwire;
	or yesneg(islessthanwire, andgate1, andgate2);
	
	assign isLessThan = islessthanwire;
	
	assign w7[31:0] = 1'b0;
	assign w8[31:0] = 1'b0;
	
	mux_8 my_mux(ctrl_ALUopcode[2:0], addout, subout, andout, orout, sllout, srlout, w7, w8, data_result);
	
	
	
endmodule
