module inputUnit
(
	input [3:0]row,
	input clock,
	input reset,
	output [3:0]col,
	output [7:0]sol, 
	output trig,
	output reg valid,
	output [3:0] value
);
wire [15:0]BCD;
wire [7:0]sign;
always @ (*) begin
	if (BCD[11:8] > 1) valid = 1;
	else if (BCD[11:8] == 1 && BCD[7:4] > 2) valid = 1;
	else if (BCD[11:8] == 1 && BCD[7:4] == 2 && BCD[3:0] > 7) valid =1;
	else valid = 0;
	end


inputMod inputMod_inst
(
	.clk(clock) ,	// input  clk_sig
	.reset(reset) ,	// input  reset_sig
	.row(row) ,	// input [3:0] row_sig
	.col(col) ,	// output [3:0] col_sig
	.out(BCD) ,	// output [DIGITS*4-1:0] out_sig
	.value(value) ,	// output [3:0] value_sig
	.trig(trig) 	// output  trig_sig
);


BCDBinarySM BCDBinarySM_inst
(
	.BCD(BCD) ,	// input [15:0] BCD_sig
	.binarySM(sign) 	// output [N-1:0] binarySM_sig
);


uns2sn uns2sn_inst
(
	.A(sign) ,	// input [7:0] A_sig
	.B(sol) 	// output [7:0] B_sig
);


endmodule
