module PC_register(clock, ctrl_writeEnable, ctrl_reset, in, out);
	
	//ctrl = reg number
	
	input clock, ctrl_writeEnable, ctrl_reset;
	input [11:0] in;

	output [11:0] out;
	
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