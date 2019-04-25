module bypass(instDX, instXM, instMW, stall, wm_hazard, wx_rd_rs, wx_rd_rt, wx_rd_rd, mx_rd_rs, mx_rd_rt, mx_rd_rd);
	input [31:0] instDX, instXM, instMW; // instruction is in second letter stage
	output stall, wm_hazard;
	
	
	wire sw_wb, sw_mem, regwrite_wb, regwrite_mem, lw_wb, lw_mem, Rtype_mem, Itype_mem, JIItype_mem, branch_mem, branch_exe, sw_exe, JIItype_exe, Itype_exe, Rtype_exe;
	
	
	Control wmcontrol(.instruction(instMW), .sw(sw_wb), .lw(lw_wb), .RegWrite(regwrite_wb));
	Control mxcontrol(.instruction(instXM), .Rtype(Rtype_mem), .lw(lw_mem), .RegWrite(regwrite_mem), .Itype(Itype_mem), .JIItype(JIItype_mem), .sw(sw_mem), .branch(branch_mem));
	Control wxcontrol(.instruction(instDX), .Rtype(Rtype_exe), .Itype(Itype_exe), .JIItype(JIItype_exe), .sw(sw_exe), .branch(branch_exe));
	
	
	// W-M
	
	wire wmxor;
//	xor xor1(wmxor[4:0], instXM[26:22], instMW[26:22]);
	fivebitxor wm_xor(.in1(instXM[26:22]), .in2(instMW[26:22]), .out(wmxor));
	and and1(wm_hazard, wmxor, sw_mem, regwrite_wb);
	
	
	// W-X
	
	//wire Rtype, Itype, JIItype, sw_wx, branch, lw_exe;	
	output wx_rd_rs;
	wire wx_rdrs_xor;
	wire RorI_exe;
	//xor xor2(wx_rdrs_xor[4:0], instMW[26:22], instDX[21:17]);
	
//	xor xor1wx(wx_rdrs_xor[4], instMW[26], instDX[21]);
//	xor xor2wx(wx_rdrs_xor[3], instMW[25], instDX[20]);
//	xor xor3wx(wx_rdrs_xor[2], instMW[24], instDX[19]);
//	xor xor4wx(wx_rdrs_xor[1], instMW[23], instDX[18]);
//	xor xor5wx(wx_rdrs_xor[0], instMW[22], instDX[17]);

	fivebitxor wx_rd_rs_xor(.in1(instMW[26:22]), .in2(instDX[21:17]), .out(wx_rdrs_xor));
	
	or roritype(RorI_exe, Rtype_exe, Itype_exe);
	wire iszero_winst;
	and myand(iszero_winst, ~instMW[26], ~instMW[25], ~instMW[24], ~instMW[23], ~instMW[22]);
	and and2(wx_rd_rs, ~iszero_winst, wx_rdrs_xor, RorI_exe, regwrite_wb);
	
	
	output wx_rd_rt;
	wire wx_rdrt_xor;
//	xor xor3(wx_rdrt_xor[4:0], instMW[26:22], instDX[16:12]);
	fivebitxor wx_rd_rt_xor(.in1(instMW[26:22]), .in2(instDX[16:12]), .out(wx_rdrt_xor));
	and and3(wx_rd_rt, ~iszero_winst, wx_rdrt_xor, Rtype_exe, regwrite_wb);
	
	output wx_rd_rd;
	wire wx_rdrd_xor;
//	xor xor4(wx_rdrd_xor[4:0], instMW[26:22], instDX[26:22]);
	fivebitxor wx_rd_rd_xor(.in1(instMW[26:22]), .in2(instDX[26:22]), .out(wx_rdrd_xor));
	wire propertype1;
	or or1(propertype1, JIItype_exe, sw_exe, branch_exe);
	and and4(wx_rd_rd, ~iszero_winst, wx_rdrd_xor, propertype1, regwrite_wb);
	// added ~iszero_winst
	
	// M-X logic
	
	output mx_rd_rs;
	wire RorI_mem;
	wire mx_rdrs_xor;
//	xor xor5(mxxor[4:0], instXM[26:22], instDX[21:17]);
	fivebitxor mx_rd_rs_xor(.in1(instXM[26:22]), .in2(instDX[21:17]), .out(mx_rdrs_xor));
	or roritype2(RorI_mem, Rtype_mem, Itype_mem);
	wire iszero_minst;
	and myand2(iszero_minst, ~instXM[26], ~instXM[25], ~instXM[24], ~instXM[23], ~instXM[22]);
	and and5(mx_rd_rs, ~iszero_minst, mx_rdrs_xor, RorI_exe, regwrite_mem);
	
	output mx_rd_rt;
	wire mx_rdrt_xor;
//	xor xor6(mx_rdrt_xor[4:0], instXM[26:22], instDX[16:12]);
	fivebitxor mx_rd_rt_xor(.in1(instXM[26:22]), .in2(instDX[16:12]), .out(mx_rdrt_xor));
	and and6(mx_rd_rt, ~iszero_minst, mx_rdrt_xor, Rtype_exe, regwrite_mem);
	
	output mx_rd_rd;
	wire mx_rdrd_xor;
//	xor xor7(mx_rdrd_xor[4:0], instMW[26:22], instDX[26:22]);
	fivebitxor mx_rd_rd_xor(.in1(instXM[26:22]), .in2(instDX[26:22]), .out(mx_rdrd_xor));
	wire propertype2;
	or or2(propertype2, JIItype_exe, branch_exe);
	and and7(mx_rd_rd, ~iszero_minst, mx_rdrd_xor, propertype2, regwrite_mem);
	// added  iszero_minst, checks instruction at memory
	
	// stall
	
	// any of the MX hazards and M is load and X is not store
	wire MX_hazard;
	or MX_hazard_or(MX_hazard, mx_rd_rs, mx_rd_rt, mx_rd_rd);
	and stall_mx(stall, MX_hazard, lw_mem, ~sw_exe);
	
endmodule	

module fivebitxor(in1, in2, out);

	input[4:0] in1, in2;
	output out;
	
	wire [4:0] inter;
	
	xor xor1(inter[4], in1[4], in2[4]);
	xor xor2(inter[3], in1[3], in2[3]);
	xor xor3(inter[2], in1[2], in2[2]);
	xor xor4(inter[1], in1[1], in2[1]);
	xor xor5(inter[0], in1[0], in2[0]);
	
	and and1(out, ~inter[4], ~inter[3], ~inter[2], ~inter[1], ~inter[0]);
	
endmodule
