module Calculator
(
	//Initializing the inputs of the input unit
	input clock, clearEntry, clearAll,
	input [3:0] row,
	output [0:6]HEX2, HEX1, HEX0,
	output HEX3,
	output [3:0]col,
	//output [3:0] Ccout,
	output ovr, zero, neg, cout,
	//output B,C, D, E,F,G, valid
	output [7:0] LEDR
);
	//Initializing registers, wires, and control unit variables
	wire [7:0] A, Rout;
	reg [7:0] out;
	reg clear;
	wire [3:0] value;
	wire trig, reset, loadA, loadB, loadR,AddSub, IUAU, entry;
	assign B = reset; assign C = loadA; assign D = AddSub; assign E = loadB; assign F = loadR; assign G = IUAU;
	always @ (*) begin
		case(IUAU)
		0: out <= A;
		1: out <= Rout;
		endcase
		if (~clearEntry) clear = 0;
		else clear = entry;
	end
	
	assign LEDR = A;

//Instantiation of the Control Unit
  CU CU_inst
(
	.value(value) ,	// input [3:0] value_sig
	.clock(clock) ,	// input  clock_sig
	.clearA(clearAll) ,	// input  clearA_sig
	.reset(reset) ,	// output  reset_sig
	.loadA(loadA) ,	// output  loadA_sig
	.loadB(loadB) ,	// output  loadB_sig
	.AddSub(AddSub) ,	// output  AddSub_sig
	.loadR(loadR) ,	// output  loadR_sig
	.IUAU(IUAU) ,	// output  IUAU_sig
	.entry(entry) ,	// output  entry_sig
	//.slow_clock(slow_clock_sig) 	// output  slow_clock_sig
);

//
//Instantiation of the input Unit
 inputUnit inputUnit_inst
(
	.row(row) ,	// input [3:0] row_sig
	.clock(clock) ,	// input  clock_sig
	.reset(reset & clearEntry) ,	// input  reset_sig
	.col(col) ,	// output [3:0] col_sig
	.sol(A) ,	// output [7:0] sol_sig
	.trig(trig) ,	// output  trig_sig
	.valid(valid) ,	// output  valid_sig
	.value(value) 	// output [3:0] value_sig
);
//
//Instantiation of the Arithmetic Unit
   AU8 AU8_inst
(
	.X(A) ,	// input [7:0] X_sig
	.InA(loadA) ,	// input  InA_sig
	.InB(loadB) ,	// input  InB_sig
	.Out(loadR) ,	// input  Out_sig
	.Clear(reset) ,	// input  Clear_sig
	.Add_Subtract(AddSub) ,	// input  Add_Subtract_sig
	.Rout(Rout) ,	// output [7:0] Rout_sig
	.Ovr(ovr),
	.Zero(zero),
	.Neg(neg),
	.Cout(court)
);

//Instantiation of the Output Unit
   outUNIT outUNIT_inst
(
	.SW7(out) ,	// input [7:0] SW7_sig
	.HEX3(HEX3) ,	// output  HEX3_sig
	.HEX2(HEX2) ,	// output [0:6] HEX2_sig
	.HEX1(HEX1) ,	// output [0:6] HEX1_sig
	.HEX0(HEX0) 	// output [0:6] HEX0_sig
);

endmodule
