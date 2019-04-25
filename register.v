module register(clock, ctrl_writeEnable, ctrl_reset, in, out);
	
	//ctrl = reg number
	
	input clock, ctrl_writeEnable, ctrl_reset;
	input [31:0] in;

	output [31:0] out;
	
	dffe_ref dflipflop1(out[31], in[31], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop2(out[30], in[30], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop3(out[29], in[29], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop4(out[28], in[28], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop5(out[27], in[27], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop6(out[26], in[26], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop7(out[25], in[25], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop8(out[24], in[24], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop9(out[23], in[23], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop10(out[22], in[22], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop11(out[21], in[21], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop12(out[20], in[20], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop13(out[19], in[19], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop14(out[18], in[18], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop15(out[17], in[17], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop16(out[16], in[16], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop17(out[15], in[15], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop18(out[14], in[14], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop19(out[13], in[13], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop20(out[12], in[12], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop21(out[11], in[11], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop22(out[10], in[10], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop23(out[9], in[9], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop24(out[8], in[8], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop25(out[7], in[7], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop26(out[6], in[6], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop27(out[5], in[5], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop28(out[4], in[4], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop29(out[3], in[3], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop30(out[2], in[2], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop31(out[1], in[1], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dflipflop32(out[0], in[0], clock, ctrl_writeEnable, ctrl_reset);
	
endmodule	