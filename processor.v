/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB                   // I: Data from port B of regfile
	 
//	 stall, wm_hazard, wx_rd_rs, wx_rd_rt, wx_rd_rd, mx_rd_rs, mx_rd_rt, mx_rd_rd
);
    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

    /* YOUR CODE STARTS HERE */
	 
	 wire [31:0] PC_IF, PC_ID, PC_EXE, PC_MEM, PC_WB, PC;
	 wire [31:0] inst_decode, inst_execute, inst_memory, inst_wb;
	 wire [31:0] data_execute, data_memory;
	 wire [31:0] val1_decode, val1_execute;
	 wire [31:0] val2_decode, val2_execute;
	 wire [31:0] ALURes_EXE, ALURes_MEM, ALURes_WB, PC_plus1_plusN;
	 wire [31:0] dataMem_out_memory, dataMem_out_writeback;
	 wire [31:0] WB_result;
	 wire [31:0] dest_EXE, dest_MEM, dest_WB; 
	 wire Br_Taken_decode, IF_Flush;
	 //wire MEM_R_EN_decode, MEM_R_EN_EXE, MEM_R_EN_MEM, MEM_R_EN_WB;
	 //wire MEM_W_EN_ID, MEM_W_EN_EXE, MEM_W_EN_MEM;
	 //wire WB_EN_ID, WB_EN_EXE, WB_EN_MEM, WB_EN_WB;
	 
	 wire [4:0] control_write_register;
	 wire isNotEqual_EXE, isLessThan_EXE;
	 wire control_wren;
	 wire [31:0] dmem_out_MtoW;
	 wire mem_read_enable_for_WB;
	 wire Jump1, Jump2, Jump2_exe;
	 
	 //stages	 
	 
//	 fetch instruction_fetch(
//		// INPUTS
//		.clk(clock),
//		.rst(reset),
//		.branchtaken(Br_Taken_decode), // fix
//		.branchimmediate(signextendedimmed),  // will have beeen sign extended from whatever it is
//		.PCIn(PC),
//		// OUTPUTS
//		.nextPC(PC_IF)
//	 );
	 
	 register PCReg (
		.clock(clock),
		.ctrl_reset(reset),
		.in(PC_IF),
		.out(PC),
		.ctrl_writeEnable(~stall)
//		.ctrl_writeEnable(1'b1)
		);
		
		wire [31:0] pc_plus_one;
		
		addmodule_all32 PC_plus1_or_branch (
		.data_operandA(32'd1),
		.data_operandB(PC),
		.cin(1'b0),
		.data_result(pc_plus_one)
		);
		
		wire [31:0] sign_extended_target;
		signExtendTarget targetsignextend(.in(inst_decode[26:0]), .out(sign_extended_target));
		
		//assign PC_IF = Jump2 ? val2_execute : (Jump1 ? **sign extended T** : PC+1 calculated in fetch copy from writeback)
		assign PC_IF = branch ? PC_plus1_plusN : (Jump2_exe ? val2_execute_inter : (Jump1 ? sign_extended_target : pc_plus_one));
		
		wire [31:0] val2_execute_inter;
		assign val2_execute_inter = mx_rd_rd ? ALURes_MEM : (wx_rd_rd ? data_writeReg : val2_execute);
		
		
		assign address_imem = PC[11:0];		// output of register, check with testing
		
		wire flush_ftod, flush_dtox;
		
		or flush1(flush_ftod, Jump1, Jump2_exe, branch);
		or flush2(flush_dtox, Jump2_exe, branch);				
	 
	 fetch_to_decode fetch_to_decode_reg (
		// INPUTS
		.clk(clock),
		.rst(reset),
		.enable(~stall),
		.PCIn(PC_IF),
		.flush(flush_ftod),
		.instructionIn(q_imem),
		// OUTPUTS
		.PC(PC_ID),
		.instruction(inst_decode)
	);
	 
	 decode decode_stage (
		// INPUTS
		.clk(clock),
		.rst(reset),
		.inst_in(inst_decode),
		.ctrlwritereg(control_write_register),
		.data_write(WB_result),
		// OUTPUTS
		.addr_readRegA(ctrl_readRegA),
		.addr_readRegB(ctrl_readRegB),
		.Jump1(Jump1),
		.Jump2(Jump2)
	);
	
	decode_to_execute decode_to_execute_reg (
		.clk(clock),
		.rst(reset),
		// INPUTS
		.PCIn(PC_ID),
		.enable(~stall),
		.flush(flush_dtox),
		.instructionIn(inst_decode),
		.dataAin(data_readRegA),
		.dataBin(data_readRegB),
		.Jump2in(Jump2),
		//OUTPUTS
		.PC(PC_EXE),
		.instruction(inst_execute),
		.dataA(val1_execute),
		.Jump2out(Jump2_exe),
		.dataB(val2_execute)
	);
	
	wire branch;
	
	execute execute_stage (
		// INPUTS
		.clk(clock),
		.val1(val1_execute),
		.val2(val2_execute),
		.PC(PC_EXE),
		.ALU_res_MEM(ALURes_MEM),
		.mx_rd_rs(mx_rd_rs),
		.wx_rd_rs(wx_rd_rs),
		.wx_rd_rt(wx_rd_rt), 
		.wx_rd_rd(wx_rd_rd), 
		.mx_rd_rt(mx_rd_rt), 
		.mx_rd_rd(mx_rd_rd),
		.instruction(inst_execute),
		.data_writereg(data_writeReg),
		// OUTPUTS
		.ALUResult(ALURes_EXE),
		.PC_plus_sign_ext_result(PC_plus1_plusN),
		.dataout(data_execute),
		.branch(branch),
		.isNotEqual_result(isNotEqual_EXE),
		.isLessThan_result(isLessThan_EXE)
	);

	execute_to_memory execute_to_memory_reg (
		.clk(clock),
		.rst(reset),
		// INPUTS
		.instructionIn(inst_execute),
		.PCin(PC_EXE),
		.flush(stall),
		.ALUresIn(ALURes_EXE),
		.datain(data_execute),		// if sw, mux in data_writereg *W-x* 
		// OUTPUTS
		.ALUresOut(ALURes_MEM),
		.dataout(data_memory),
		.PCout(PC_MEM),
		.instruction(inst_memory)
	);
	
	//
	
	Control my_control(.instruction(inst_memory), .MemWrite(control_wren));
	
	assign wren = control_wren;
	assign address_dmem =  ALURes_MEM;
	assign data = wm_hazard ? data_writeReg : data_memory;
	
	// write enable is on we write data_in to dmem; if not, we read data from same address port
	
	memory_to_writeback memory_to_writeback_reg(
		.clk(clock),
		.rst(reset),
		// INPUTS
		.instructionin(inst_memory),
		.aluin(ALURes_MEM),
		.PCin(PC_MEM),
		.dmemin(q_dmem),
		// OUTPUTS
		.instructionout(inst_wb),
		.aluout(ALURes_WB),
		.PCout(PC_WB),
		.dmemout(dmem_out_MtoW)
	);	
	
	//assign ctrl_writeReg = inst_wb[26:22];
	
	Control my_control2(.instruction(inst_wb), .MemRead(mem_read_enable_for_WB), .RegWrite(ctrl_writeEnable));
	
	writeback writeback_stage (
		// INPUTS
		.memoryReadEnable(mem_read_enable_for_WB),
		.memoryData(dmem_out_MtoW),
		.aluout(ALURes_WB),
		.instruction(inst_wb),
		.PC(PC_WB),
		// OUTPUTS
		.writeback_result(data_writeReg),
		.ctrl_writeReg(ctrl_writeReg)
	);
 
//	output stall, wm_hazard, wx_rd_rs, wx_rd_rt, wx_rd_rd, mx_rd_rs, mx_rd_rt, mx_rd_rd;
//		bypass my_bypass(.instDX(inst_execute), .instXM(inst_memory), .instMW(inst_wb),
//		.stall(stall), .wm_hazard(wm_hazard), .wx_rd_rs(wx_rd_rs), .wx_rd_rt(wx_rd_rt),
//		.wx_rd_rd(wx_rd_rd), .mx_rd_rs(mx_rd_rs), .mx_rd_rt(mx_rd_rt), .mx_rd_rd(mx_rd_rd));

	wire stall, wm_hazard, wx_rd_rs, wx_rd_rt, wx_rd_rd, mx_rd_rs, mx_rd_rt, mx_rd_rd;
		bypass my_bypass(.instDX(inst_execute), .instXM(inst_memory), .instMW(inst_wb),
		.stall(stall), .wm_hazard(wm_hazard), .wx_rd_rs(wx_rd_rs), .wx_rd_rt(wx_rd_rt),
		.wx_rd_rd(wx_rd_rd), .mx_rd_rs(mx_rd_rs), .mx_rd_rt(mx_rd_rt), .mx_rd_rd(mx_rd_rd));

//	assign stall = 1'b0;
//	assign wm_hazard = 1'b0;
//	assign wx_rd_rs = 1'b0;
//	assign wx_rd_rt = 1'b0;
//	assign wx_rd_rd = 1'b0; 
//	assign mx_rd_rs = 1'b0;
//	assign mx_rd_rt = 1'b0; 
//	assign mx_rd_rd = 1'b0;
	
	//output branch;
	
	
	
 
endmodule