module decode (clk, rst, inst_in, ctrlwritereg, data_write, addr_readRegA, addr_readRegB, Jump1, Jump2);
  input clk, rst;
  input [4:0] ctrlwritereg;
  input [31:0] data_write, inst_in;
  
  output [4:0] addr_readRegA, addr_readRegB;

  assign addr_readRegA = inst_in[21:17]; //rs
  assign addr_readRegB = Jump2orItype ? inst_in[26:22] : inst_in[16:12]; //rd or rt
  
  // set PC to target for JI inst
  output Jump1, Jump2;
  wire Itype;
  Control decode_controller(.instruction(inst_in), .JItype(Jump1), .JIItype(Jump2), .Itype(Itype));
  
  wire Jump2orItype;
  or j2orI(Jump2orItype, Jump2, Itype);
  
  
  // prioritize J2 instruction in execute over J1 instruction in decode if its there
  
  
//  regfile decoderegfile(.clock(clk), .ctrl_writeEnable(1'b1), .ctrl_reset(rst), .ctrl_writeReg(ctrlwritereg), .ctrl_readRegA(s1),
//		.ctrl_readRegB(s2), .data_writeReg(data_write), .muxoutA(val1), .muxoutB(val2));
//		
//	 rd, rs, rt, shamt, aluopcode (check), immediate value (check), jump target (check), branch instruction (check), jump instruction (check), ALU instruction (check), I instruction (check)
//		sw or load word
//	
//	 write to reg or memory (check)
//	
//	 lw writes to register (check)
//	
//	 write to reg --> write enable. don't write until write back stage. give it to latch and not regfile yet. writeback stage give to to the regfile.
//	
//	Control control_decode(.RegDst(), .ALUSrc(), .MemtoReg(), .RegWrite(), .MemRead(), .MemWrite(),
//		.branch(), .jumptarget(), .immed_value(), .ALUOp(), .rd_reg(), .rs_reg(), .Rtype(), .Itype(),
//		.JItype(), .JIItype(), .jump(), .SignZero(), .instruction());


endmodule 