/**
 * TA Grading Skeleton
 */

module skeleton(
	
	// Control Inputs
	A_clock, 
	B_reset,

	// Cycle Counter
	C_cycle_num,

	// IMEM
	D_fetch_pc, 
	E_fetch_insn,

	// DMEM
	F_address_dmem, 
	G_read_dmem, 
	H_wren_dmem, 
	I_write_dmem,

	// Register File
	J_ctrl_readRegA, 
	K_data_readRegA,
	L_ctrl_readRegB, 
	M_data_readRegB,
	N_ctrl_writeEnable, 
	O_ctrl_writeReg, 
	P_data_writeReg,
	
	stall, wm_hazard, wx_rd_rs, wx_rd_rt, wx_rd_rd, mx_rd_rs, mx_rd_rt, mx_rd_rd
);

    input A_clock, B_reset;
    output [31:0] C_cycle_num, E_fetch_insn, I_write_dmem, G_read_dmem, K_data_readRegA, M_data_readRegB, P_data_writeReg;
    output [11:0] D_fetch_pc, F_address_dmem;
    output [4:0] J_ctrl_readRegA, L_ctrl_readRegB, O_ctrl_writeReg;
    output N_ctrl_writeEnable, H_wren_dmem;
	 output stall, wm_hazard, wx_rd_rs, wx_rd_rt, wx_rd_rd, mx_rd_rs, mx_rd_rt, mx_rd_rd;

    /** CONTROL SIGNALS **/
    wire clock, reset;
    assign clock = A_clock;
    assign reset = B_reset;

    /** CYCLE COUNTER **/
    reg [31:0] C_cycle_num, cycle_reg;
    always @(posedge clock) begin
        if(reset) cycle_reg <= 32'h00000000;
	    else cycle_reg <= cycle_reg + 32'h00000001;
    end
    always @(negedge clock) begin
		C_cycle_num = cycle_reg;
	 end

    /** IMEM **/
    wire [11:0] address_imem;
    wire [31:0] read_imem;
    imem my_imem(
        .address    (address_imem),            // address of instruction
        .clock      (~clock),                  // inverted clock
        .q          (read_imem)                // the raw instruction
    );
    assign D_fetch_pc = address_imem;
    assign E_fetch_insn = read_imem;

    /** DMEM **/
    wire [11:0] address_dmem;
    wire [31:0] write_dmem, read_dmem;
    wire wren_dmem;
    dmem my_dmem(
        .address    (address_dmem),            // address of data
        .clock      (~clock),                  // inverted clock
        .data	     (write_dmem),              // data you want to write
        .wren	     (wren_dmem),               // write enable
        .q       	  (read_dmem)                // data from dmem
    );
    assign F_address_dmem = address_dmem;
    assign G_read_dmem = read_dmem;
    assign H_wren_dmem = wren_dmem;
    assign I_write_dmem = write_dmem;

    /** REGFILE **/
    wire ctrl_writeEnable;
    wire [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    wire [31:0] data_writeReg;
    wire [31:0] data_readRegA, data_readRegB;
    regfile my_regfile(
        .clock         (~clock),
        .ctrl_writeEnable(ctrl_writeEnable),
        .ctrl_reset    (reset),
        .ctrl_writeReg (ctrl_writeReg),
        .ctrl_readRegA (ctrl_readRegA),
        .ctrl_readRegB (ctrl_readRegB),
        .data_writeReg (data_writeReg),
        .data_readRegA (data_readRegA),
        .data_readRegB (data_readRegB)
    );
    assign J_ctrl_readRegA = ctrl_readRegA;
    assign K_data_readRegA = data_readRegA;
    assign L_ctrl_readRegB = ctrl_readRegB;
    assign M_data_readRegB = data_readRegB;
    assign N_ctrl_writeEnable = ctrl_writeEnable;
    assign O_ctrl_writeReg = ctrl_writeReg;
    assign P_data_writeReg = data_writeReg;

    /** PROCESSOR **/
    processor my_processor(
        // Control signals
        .clock         (clock),         // I: The master clock
        .reset         (reset),         // I: A reset signal

        // Imem
        .address_imem  (address_imem),  // O: The address of the instruction to get from imem
        .q_imem        (read_imem),     // I: The instruction from imem

        // Dmem
        .address_dmem  (address_dmem),  // O: The address of the data to get or put from/to dmem
        .data          (write_dmem),    // O: The data to write to dmem
        .wren          (wren_dmem),     // O: Write enable for dmem
        .q_dmem        (read_dmem),     // I: The data from dmem

        // Regfile
        .ctrl_writeEnable(ctrl_writeEnable), // O: Write enable for regfile
        .ctrl_writeReg (ctrl_writeReg), // O: Register to write to in regfile
        .ctrl_readRegA (ctrl_readRegA), // O: Register to read from port A of regfile
        .ctrl_readRegB (ctrl_readRegB), // O: Register to read from port B of regfile
        .data_writeReg (data_writeReg), // O: Data to write to for regfile
        .data_readRegA (data_readRegA), // I: Data from port A of regfile
        .data_readRegB (data_readRegB)  // I: Data from port B of regfile
//		  
//		  .stall(stall), 
//		  .wm_hazard(wm_hazard), 
//		  .wx_rd_rs(wx_rd_rs), 
//		  .wx_rd_rt(wx_rd_rt), 
//		  .wx_rd_rd(wx_rd_rd), 
//		  .mx_rd_rs(mx_rd_rs), 
//		  .mx_rd_rt(mx_rd_rt), 
//		  .mx_rd_rd(mx_rd_rd)
    );

endmodule
