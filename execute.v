module execute (clk, wx_rd_rs, mx_rd_rs, wx_rd_rt, wx_rd_rd, mx_rd_rt, mx_rd_rd, instruction, ALU_res_MEM, PC, val1, val2, data_writereg, ALUResult, PC_plus_sign_ext_result, dataout, isNotEqual_result, branch, isLessThan_result);
  input clk, wx_rd_rs, mx_rd_rs, wx_rd_rt, wx_rd_rd, mx_rd_rt, mx_rd_rd;
  input [31:0] PC, val1, val2, instruction, ALU_res_MEM;
  input [31:0] data_writereg;
  output [31:0] ALUResult, PC_plus_sign_ext_result, dataout;
  output isNotEqual_result, isLessThan_result;
  wire [4:0] ALU_opcode;

  wire [31:0] ALU_val2, sign_extended_imm;
	
	signExtend signExtendimmediate(
    .in(instruction[15:0]),
    .out(sign_extended_imm)
   );
  
  wire [4:0] notout;
  
   not not0(notout[0], instruction[31]);
	not not1(notout[1], instruction[30]);
	not not2(notout[2], instruction[29]);
	not not3(notout[3], instruction[28]);
	not not4(notout[4], instruction[27]);
	
	wire is_Imm, addi, lw, sw;
	
	or is_immediate(is_Imm, addi, lw, sw);
	
	assign ALU_opcode = Rtype ? instruction[6:2] : (branchyes ? 5'b00001 : 5'b00000);
	
	mux_2 my_mux(
    .in0(val2),
    .in1(sign_extended_imm),
    .select(is_Imm),
    .out(ALU_val2)
	);
  
  alu my_primary_alu(
    .data_operandA(val1_exe_inter),
    .data_operandB(val2_exe_inter_mx),
	 .ctrl_shiftamt(instruction[11:7]),
    .ctrl_ALUopcode(ALU_opcode),
	 .isNotEqual(isNotEqual_result),
	 .isLessThan(isLessThan_result),
    .data_result(ALUResult)
  );
  
  wire bne, blt, Rtype;
  
  Control executecontrol(.instruction(instruction), .Rtype(Rtype), .branch1(bne), .branch2(blt), .AddImmediate(addi), .lw(lw), .sw(sw));
  
  output branch;
  
  addmodule_all32 PC_plus1_plusN (
    .data_operandA(sign_extended_imm),
    .data_operandB(PC),
	 .cin(1'b0),
    .data_result(PC_plus_sign_ext_result)
  );
  
  //bne
  
  wire bne_taken;
  and bnetaken(bne_taken, bne, isNotEqual_result);
  
  //blt
  
  wire blt_taken;
  and blttaken(blt_taken, isNotEqual_result, ~isLessThan_result, blt);
  
  or branch_taken(branch, blt_taken, bne_taken);
  
  assign dataout = wx_rd_rd ? data_writereg : val2;
  
  // pass in hazard values as inputs. and rd value from w (datawritereg, add as input) and m
	wire [31:0] val1_exe_inter;
	assign val1_exe_inter = mx_rd_rs ? ALU_res_MEM : (wx_rd_rs ? data_writereg : val1);
	
	wire [31:0] val2_exe_inter;
	assign val2_exe_inter = wx_rd_rt ? data_writereg : (wx_rd_rd_branch ? data_writereg : ALU_val2);
	
	wire [31:0] val2_exe_inter_mx;
	assign val2_exe_inter_mx = mx_rd_rt ? ALU_res_MEM : (mx_rd_rd_branch ? ALU_res_MEM : val2_exe_inter);
	
	wire branchyes, wx_rd_rd_branch, mx_rd_rd_branch;
	or branchor(branchyes, bne, blt);
	and wxrdrdbranch(wx_rd_rd_branch, branchyes, wx_rd_rd);
	and mxrdrdbranch(mx_rd_rd_branch, branchyes, mx_rd_rd);
	
	
endmodule