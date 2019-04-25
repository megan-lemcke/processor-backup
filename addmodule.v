module addmodule(data_operandA, data_operandB, cin, data_result, cout);

	input [7:0] data_operandA, data_operandB;
	input cin;
	output [7:0] data_result;
	output cout;
	
	wire [8:0] c;
	wire [7:0] g;
	wire [7:0] p;
	wire [7:0] pc;
	
	generate

		genvar a;

		for(a = 0; a < 8; a = a + 1) begin : and1_gen_var
			 and gi(g[a], data_operandA[a], data_operandB[a]); 
		end

	endgenerate
	
	generate

		genvar b;

		for(b = 0; b < 8; b = b + 1) begin : or1_gen_var
			 or pi(p[b], data_operandA[b], data_operandB[b]); 
		end

	endgenerate
	
	assign c[0] = cin;
	
	// c1	
	and pc0(pc[0], p[0], cin);
	or c1(c[1], g[0], pc[0]);
	
	// c2
	wire wp1g0;
	and pc1(pc[1], p[1], p[0], cin);
	and p1g0(wp1g0, p[1], g[0]);
	or c2(c[2], g[1], wp1g0, pc[1]);
	
	// c3
	wire wp2g1, wp2p1g0;
	and pc2(pc[2], p[2], p[1], p[0], cin);
	and p2p1g0(wp2p1g0, p[2], p[1], g[0]);
	and p2g1(wp2g1, p[2], g[1]);
	or c3(c[3], g[2], wp2g1, wp2p1g0, pc[2]);
	
	// c4
	wire wp3g2, wp3p2g1, wp3p2p1g0;
	and pc3(pc[3], p[3], p[2], p[1], p[0], cin);
	and p3g2(wp3g2, p[3], g[2]);
	and p3p2g1(wp3p2g1, p[3], p[2], g[1]);
	and p3p2p1g0(wp3p2p1g0, p[3], p[2], p[1], g[0]);
	or c4(c[4], g[3], wp3g2, wp3p2g1, wp3p2p1g0, pc[3]);
	
	// c5
	wire wp4g3, wp4p3g2, wp4p3p2g1, wp4p3p2p1g0;
	and pc4(pc[4], p[4], p[3], p[2], p[1], p[0], cin);
	and p4g3(wp4g3, p[4], g[3]);
	and p4p3g2(wp4p3g2, p[4], p[3], g[2]);
	and p4p3p2g1(wp4p3p2g1, p[4], p[3], p[2], g[1]);
	and p4p3p2p1g0(wp4p3p2p1g0, p[4], p[3], p[2], p[1], g[0]);
	or c5(c[5], g[4], wp4g3, wp4p3g2, wp4p3p2g1, wp4p3p2p1g0, pc[4]);
	
	// c6
	wire wp5g4, wp5p4g3, wp5p4p3g2, wp5p4p3p2g1, wp5p4p3p2p1g0;
	and pc5(pc[5], p[5], p[4], p[3], p[2], p[1], p[0], cin);
	and p5g4(wp5g4, p[5], g[4]);
	and p5p4g3(wp5p4g3, p[5], p[4], g[3]);
	and p5p4p3g2(wp5p4p3g2, p[5], p[4], p[3], g[2]);
	and p5p4p3p2g1(wp5p4p3p2g1, p[5], p[4], p[3], p[2], g[1]);
	and p5p4p3p2p1g0(wp5p4p3p2p1g0, p[5], p[4], p[3], p[2], p[1], g[0]);
	or c6(c[6], g[5], wp5g4, wp5p4g3, wp5p4p3g2, wp5p4p3p2g1, wp5p4p3p2p1g0, pc[5]);	
	
	// c7
	wire wp6g5, wp6p5g4, wp6p5p4g3, wp6p5p4p3g2, wp6p5p4p3p2g1, wp6p5p4p3p2p1g0;
	and pc6(pc[6], p[6], p[5], p[4], p[3], p[2], p[1], p[0], cin);
	and p6g5(wp6g5, p[6], g[5]);
	and p6p5g4(wp6p5g4, p[6], p[5], g[4]);
	and p6p5p4g3(wp6p5p4g3, p[6], p[5], p[4], g[3]);
	and p6p5p4p3g2(wp6p5p4p3g2, p[6], p[5], p[4], p[3], g[2]);
	and p6p5p4p3p2g1(wp6p5p4p3p2g1, p[6], p[5], p[4], p[3], p[2], g[1]);
	and p6p5p4p3p2p1g0(wp6p5p4p3p2p1g0, p[6], p[5], p[4], p[3], p[2], p[1], g[0]);
	or c7(c[7], g[6], wp6g5, wp6p5g4, wp6p5p4g3, wp6p5p4p3g2, wp6p5p4p3p2g1, wp6p5p4p3p2p1g0, pc[6]);
	
	// c8
	
	wire wp7g6, wp7p6g5, wp7p6p5g4, wp7p6p5p4g3, wp7p6p5p4p3g2, wp7p6p5p4p3p2g1, wp7p6p5p4p3p2p1g0;
	and pc7(pc[7], p[7], p[6], p[5], p[4], p[3], p[2], p[1], p[0], cin);
	and p7g6(wp7g6, p[7], g[6]);
	and p7p6g5(wp7p6g5, p[7], p[6], g[5]);
	and p7p6p5g4(wp7p6p5g4, p[7], p[6], p[5], g[4]);
	and p7p6p5p4g3(wp7p6p5p4g3, p[7], p[6], p[5], p[4], g[3]);
	and p7p6p5p4p3g2(wp7p6p5p4p3g2, p[7], p[6], p[5], p[4], p[3], g[2]);
	and p7p6p5p4p3p2g1(wp7p6p5p4p3p2g1, p[7], p[6], p[5], p[4], p[3], p[2], g[1]);
	and p7p6p5p4p3p2p1g0(wp7p6p5p4p3p2p1g0, p[7], p[6], p[5], p[4], p[3], p[2], p[1], g[0]);	
	or c8(c[8], g[7], wp7g6, wp7p6g5, wp7p6p5g4, wp7p6p5p4g3, wp7p6p5p4p3g2, wp7p6p5p4p3p2g1, wp7p6p5p4p3p2p1g0, pc[7]);
	
	
	assign cout = c[8];
	
	generate

		genvar j;

		for(j = 0; j < 8; j = j + 1) begin : xorgenvar
			 xor my_xor(data_result[j], data_operandA[j], data_operandB[j], c[j]); 
		end

	endgenerate
	
endmodule
