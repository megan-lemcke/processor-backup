module regfile(clock, ctrl_writeEnable, ctrl_reset, ctrl_writeReg, ctrl_readRegA, ctrl_readRegB, data_writeReg, data_readRegA, data_readRegB);

	input clock, ctrl_writeEnable, ctrl_reset;
	input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [31:0] data_writeReg;

	wire [31:0] out;
	wire [31:0] fout;
	wire [4:0] notout;
	//output [31:0] tristateoutA, tristateoutB;

	output [31:0] data_readRegA, data_readRegB;

	//writeenable is high, and write to that specific register
	
	not not0(notout[0], ctrl_writeReg[0]);
	not not1(notout[1], ctrl_writeReg[1]);
	not not2(notout[2], ctrl_writeReg[2]);
	not not3(notout[3], ctrl_writeReg[3]);
	not not4(notout[4], ctrl_writeReg[4]);

	//decoder
	
	and and0(out[0], notout[4], notout[3], notout[2], notout[1], notout[0]);
	and and1(out[1], notout[4], notout[3], notout[2], notout[1], ctrl_writeReg[0]);
	and and2(out[2], notout[4], notout[3], notout[2], ctrl_writeReg[1], notout[0]);
	and and3(out[3], notout[4], notout[3], notout[2], ctrl_writeReg[1], ctrl_writeReg[0]);
	and and4(out[4], notout[4], notout[3], ctrl_writeReg[2], notout[1], notout[0]);
	and and5(out[5], notout[4], notout[3], ctrl_writeReg[2], notout[1], ctrl_writeReg[0]);
	and and6(out[6], notout[4], notout[3], ctrl_writeReg[2], ctrl_writeReg[1], notout[0]);
	and and7(out[7], notout[4], notout[3], ctrl_writeReg[2], ctrl_writeReg[1], ctrl_writeReg[0]);
	and and8(out[8], notout[4], ctrl_writeReg[3], notout[2], notout[1], notout[0]);
	and and9(out[9], notout[4], ctrl_writeReg[3], notout[2], notout[1], ctrl_writeReg[0]);
	and and10(out[10], notout[4], ctrl_writeReg[3], notout[2], ctrl_writeReg[1], notout[0]);
	and and11(out[11], notout[4], ctrl_writeReg[3], notout[2], ctrl_writeReg[1], ctrl_writeReg[0]);
	and and12(out[12], notout[4], ctrl_writeReg[3], ctrl_writeReg[2], notout[1], notout[0]);
	and and13(out[13], notout[4], ctrl_writeReg[3], ctrl_writeReg[2], notout[1], ctrl_writeReg[0]);
	and and14(out[14], notout[4], ctrl_writeReg[3], ctrl_writeReg[2], ctrl_writeReg[1], notout[0]);
	and and15(out[15], notout[4], ctrl_writeReg[3], ctrl_writeReg[2], ctrl_writeReg[1], ctrl_writeReg[0]);
	and and16(out[16], ctrl_writeReg[4], notout[3], notout[2], notout[1], notout[0]);
	and and17(out[17], ctrl_writeReg[4], notout[3], notout[2], notout[1], ctrl_writeReg[0]);
	and and18(out[18], ctrl_writeReg[4], notout[3], notout[2], ctrl_writeReg[1], notout[0]);
	and and19(out[19], ctrl_writeReg[4], notout[3], notout[2], ctrl_writeReg[1], ctrl_writeReg[0]);
	and and20(out[20], ctrl_writeReg[4], notout[3], ctrl_writeReg[2], notout[1], notout[0]);
	and and21(out[21], ctrl_writeReg[4], notout[3], ctrl_writeReg[2], notout[1], ctrl_writeReg[0]);
	and and22(out[22], ctrl_writeReg[4], notout[3], ctrl_writeReg[2], ctrl_writeReg[1], notout[0]);
	and and23(out[23], ctrl_writeReg[4], notout[3], ctrl_writeReg[2], ctrl_writeReg[1], ctrl_writeReg[0]);
	and and24(out[24], ctrl_writeReg[4], ctrl_writeReg[3], notout[2], notout[1], notout[0]);
	and and25(out[25], ctrl_writeReg[4], ctrl_writeReg[3], notout[2], notout[1], ctrl_writeReg[0]);
	and and26(out[26], ctrl_writeReg[4], ctrl_writeReg[3], notout[2], ctrl_writeReg[1], notout[0]);
	and and27(out[27], ctrl_writeReg[4], ctrl_writeReg[3], notout[2], ctrl_writeReg[1], ctrl_writeReg[0]);
	and and28(out[28], ctrl_writeReg[4], ctrl_writeReg[3], ctrl_writeReg[2], notout[1], notout[0]);
	and and29(out[29], ctrl_writeReg[4], ctrl_writeReg[3], ctrl_writeReg[2], notout[1], ctrl_writeReg[0]);
	and and30(out[30], ctrl_writeReg[4], ctrl_writeReg[3], ctrl_writeReg[2], ctrl_writeReg[1], notout[0]);
	and and31(out[31], ctrl_writeReg[4], ctrl_writeReg[3], ctrl_writeReg[2], ctrl_writeReg[1], ctrl_writeReg[0]);
	
	and a0(fout[0], out[0], ctrl_writeEnable);
	and a1(fout[1], out[1], ctrl_writeEnable);
	and a2(fout[2], out[2], ctrl_writeEnable);
	and a3(fout[3], out[3], ctrl_writeEnable);
	and a4(fout[4], out[4], ctrl_writeEnable);
	and a5(fout[5], out[5], ctrl_writeEnable);
	and a6(fout[6], out[6], ctrl_writeEnable);
	and a7(fout[7], out[7], ctrl_writeEnable);
	and a8(fout[8], out[8], ctrl_writeEnable);
	and a9(fout[9], out[9], ctrl_writeEnable);
	and a10(fout[10], out[10], ctrl_writeEnable);
	and a11(fout[11], out[11], ctrl_writeEnable);
	and a12(fout[12], out[12], ctrl_writeEnable);
	and a13(fout[13], out[13], ctrl_writeEnable);
	and a14(fout[14], out[14], ctrl_writeEnable);
	and a15(fout[15], out[15], ctrl_writeEnable);
	and a16(fout[16], out[16], ctrl_writeEnable);
	and a17(fout[17], out[17], ctrl_writeEnable);
	and a18(fout[18], out[18], ctrl_writeEnable);
	and a19(fout[19], out[19], ctrl_writeEnable);
	and a20(fout[20], out[20], ctrl_writeEnable);
	and a21(fout[21], out[21], ctrl_writeEnable);
	and a22(fout[22], out[22], ctrl_writeEnable);
	and a23(fout[23], out[23], ctrl_writeEnable);
	and a24(fout[24], out[24], ctrl_writeEnable);
	and a25(fout[25], out[25], ctrl_writeEnable);
	and a26(fout[26], out[26], ctrl_writeEnable);
	and a27(fout[27], out[27], ctrl_writeEnable);
	and a28(fout[28], out[28], ctrl_writeEnable);
	and a29(fout[29], out[29], ctrl_writeEnable);
	and a30(fout[30], out[30], ctrl_writeEnable);
	and a31(fout[31], out[31], ctrl_writeEnable);

//	generate

//		genvar c;

	//	for(c = 0; c < 32; c = c + 1) begin : tristateA
	//		assign tristateoutA[c] = ctrl_readRegA ? w[c] : 32'bz; 
	//	end

//	endgenerate
	
//	generate

	//	genvar d;

		//for(d = 0; d < 32; d = d + 1) begin : tristateB
			//assign tristateoutB[d] = ctrl_readRegB ? w[d] : 32'bz; 
		//end

//	endgenerate
/*
	assign tristateoutA[0] = ctrl_readRegA ? w0 : 32'bz; 
	assign tristateoutA[1] = ctrl_readRegA ? w1 : 32'bz; 
	assign tristateoutA[2] = ctrl_readRegA ? w2 : 32'bz; 
	assign tristateoutA[3] = ctrl_readRegA ? w3 : 32'bz; 
	assign tristateoutA[4] = ctrl_readRegA ? w4 : 32'bz; 
	assign tristateoutA[5] = ctrl_readRegA ? w5 : 32'bz; 
	assign tristateoutA[6] = ctrl_readRegA ? w6 : 32'bz; 
	assign tristateoutA[7] = ctrl_readRegA ? w7 : 32'bz; 
	assign tristateoutA[8] = ctrl_readRegA ? w8 : 32'bz; 
	assign tristateoutA[9] = ctrl_readRegA ? w9 : 32'bz; 
	assign tristateoutA[10] = ctrl_readRegA ? w10 : 32'bz; 
	assign tristateoutA[11] = ctrl_readRegA ? w11 : 32'bz; 
	assign tristateoutA[12] = ctrl_readRegA ? w12 : 32'bz; 
	assign tristateoutA[13] = ctrl_readRegA ? w13 : 32'bz; 
	assign tristateoutA[14] = ctrl_readRegA ? w14 : 32'bz; 
	assign tristateoutA[15] = ctrl_readRegA ? w15 : 32'bz; 
	assign tristateoutA[16] = ctrl_readRegA ? w16 : 32'bz; 
	assign tristateoutA[17] = ctrl_readRegA ? w17 : 32'bz; 
	assign tristateoutA[18] = ctrl_readRegA ? w18 : 32'bz; 
	assign tristateoutA[19] = ctrl_readRegA ? w19 : 32'bz; 
	assign tristateoutA[20] = ctrl_readRegA ? w20 : 32'bz; 
	assign tristateoutA[21] = ctrl_readRegA ? w21 : 32'bz; 
	assign tristateoutA[22] = ctrl_readRegA ? w22 : 32'bz; 
	assign tristateoutA[23] = ctrl_readRegA ? w23 : 32'bz; 
	assign tristateoutA[24] = ctrl_readRegA ? w24 : 32'bz; 
	assign tristateoutA[25] = ctrl_readRegA ? w25 : 32'bz; 
	assign tristateoutA[26] = ctrl_readRegA ? w26 : 32'bz; 
	assign tristateoutA[27] = ctrl_readRegA ? w27 : 32'bz; 
	assign tristateoutA[28] = ctrl_readRegA ? w28 : 32'bz; 
	assign tristateoutA[29] = ctrl_readRegA ? w29 : 32'bz; 
	assign tristateoutA[30] = ctrl_readRegA ? w30 : 32'bz; 
	assign tristateoutA[31] = ctrl_readRegA ? w31 : 32'bz;
	
	assign tristateoutB[0] = ctrl_readRegB ? w0 : 32'bz; 
	assign tristateoutB[1] = ctrl_readRegB ? w1 : 32'bz; 
	assign tristateoutB[2] = ctrl_readRegB ? w2 : 32'bz; 
	assign tristateoutB[3] = ctrl_readRegB ? w3 : 32'bz; 
	assign tristateoutB[4] = ctrl_readRegB ? w4 : 32'bz; 
	assign tristateoutB[5] = ctrl_readRegB ? w5 : 32'bz; 
	assign tristateoutB[6] = ctrl_readRegB ? w6 : 32'bz; 
	assign tristateoutB[7] = ctrl_readRegB ? w7 : 32'bz; 
	assign tristateoutB[8] = ctrl_readRegB ? w8 : 32'bz; 
	assign tristateoutB[9] = ctrl_readRegB ? w9 : 32'bz; 
	assign tristateoutB[10] = ctrl_readRegB ? w10 : 32'bz; 
	assign tristateoutB[11] = ctrl_readRegB ? w11 : 32'bz; 
	assign tristateoutB[12] = ctrl_readRegB ? w12 : 32'bz; 
	assign tristateoutB[13] = ctrl_readRegB ? w13 : 32'bz; 
	assign tristateoutB[14] = ctrl_readRegB ? w14 : 32'bz; 
	assign tristateoutB[15] = ctrl_readRegB ? w15 : 32'bz; 
	assign tristateoutB[16] = ctrl_readRegB ? w16 : 32'bz; 
	assign tristateoutB[17] = ctrl_readRegB ? w17 : 32'bz; 
	assign tristateoutB[18] = ctrl_readRegB ? w18 : 32'bz; 
	assign tristateoutB[19] = ctrl_readRegB ? w19 : 32'bz; 
	assign tristateoutB[20] = ctrl_readRegB ? w20 : 32'bz; 
	assign tristateoutB[21] = ctrl_readRegB ? w21 : 32'bz; 
	assign tristateoutB[22] = ctrl_readRegB ? w22 : 32'bz; 
	assign tristateoutB[23] = ctrl_readRegB ? w23 : 32'bz; 
	assign tristateoutB[24] = ctrl_readRegB ? w24 : 32'bz; 
	assign tristateoutB[25] = ctrl_readRegB ? w25 : 32'bz; 
	assign tristateoutB[26] = ctrl_readRegB ? w26 : 32'bz; 
	assign tristateoutB[27] = ctrl_readRegB ? w27 : 32'bz; 
	assign tristateoutB[28] = ctrl_readRegB ? w28 : 32'bz; 
	assign tristateoutB[29] = ctrl_readRegB ? w29 : 32'bz; 
	assign tristateoutB[30] = ctrl_readRegB ? w30 : 32'bz; 
	assign tristateoutB[31] = ctrl_readRegB ? w31 : 32'bz;
	*/

	wire [31:0] w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31;

	mux_32 mymuxA(ctrl_readRegA, w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31, data_readRegA);
	mux_32 mymuxB(ctrl_readRegB, w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31, data_readRegB);

	register register0(clock, fout[0], 1'b1, 32'd0, w0);
	register register1(clock, fout[1], ctrl_reset, data_writeReg, w1);
	register register2(clock, fout[2], ctrl_reset, data_writeReg, w2);
	register register3(clock, fout[3], ctrl_reset, data_writeReg, w3);
	register register4(clock, fout[4], ctrl_reset, data_writeReg, w4);
	register register5(clock, fout[5], ctrl_reset, data_writeReg, w5);
	register register6(clock, fout[6], ctrl_reset, data_writeReg, w6);
	register register7(clock, fout[7], ctrl_reset, data_writeReg, w7);
	register register8(clock, fout[8], ctrl_reset, data_writeReg, w8);
	register register9(clock, fout[9], ctrl_reset, data_writeReg, w9);
	register register10(clock, fout[10], ctrl_reset, data_writeReg, w10);
	register register11(clock, fout[11], ctrl_reset, data_writeReg, w11);
	register register12(clock, fout[12], ctrl_reset, data_writeReg, w12);
	register register13(clock, fout[13], ctrl_reset, data_writeReg, w13);
	register register14(clock, fout[14], ctrl_reset, data_writeReg, w14);
	register register15(clock, fout[15], ctrl_reset, data_writeReg, w15);
	register register16(clock, fout[16], ctrl_reset, data_writeReg, w16);
	register register17(clock, fout[17], ctrl_reset, data_writeReg, w17);
	register register18(clock, fout[18], ctrl_reset, data_writeReg, w18);
	register register19(clock, fout[19], ctrl_reset, data_writeReg, w19);
	register register20(clock, fout[20], ctrl_reset, data_writeReg, w20);
	register register21(clock, fout[21], ctrl_reset, data_writeReg, w21);
	register register22(clock, fout[22], ctrl_reset, data_writeReg, w22);
	register register23(clock, fout[23], ctrl_reset, data_writeReg, w23);
	register register24(clock, fout[24], ctrl_reset, data_writeReg, w24);
	register register25(clock, fout[25], ctrl_reset, data_writeReg, w25);
	register register26(clock, fout[26], ctrl_reset, data_writeReg, w26);
	register register27(clock, fout[27], ctrl_reset, data_writeReg, w27);
	register register28(clock, fout[28], ctrl_reset, data_writeReg, w28);
	register register29(clock, fout[29], ctrl_reset, data_writeReg, w29);
	register register30(clock, fout[30], ctrl_reset, data_writeReg, w30);
	register register31(clock, fout[31], ctrl_reset, data_writeReg, w31);

endmodule 