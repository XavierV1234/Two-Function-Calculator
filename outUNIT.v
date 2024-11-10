module outUNIT(
	input [7:0] SW7,
	output HEX3,
	output[0:6] HEX2, HEX1, HEX0);
	
	wire[7:0]sigMAG;
	wire[3:0]ones;
	wire[3:0]tens;
	wire[1:0]hundreds;
	
	

twoSIGN twoSIGN
(
	.A(SW7) ,	// input [N-1:0] A_sig
	.B(sigMAG[7:0]) 	// output [N-1:0] B_sig
);

defparam twoSIGN .N = 8;

binary2bcd binary2bcd
(
	.A(sigMAG) ,	// input [7:0] A_sig
	.ONES(ones) ,	// output [3:0] ONES_sig
	.TENS(tens) ,	// output [3:0] TENS_sig
	.HUNDREDS(hundreds) 	// output [1:0] HUNDREDS_sig
);

binary2hex one
(
	.BIN(ones) ,	// input [3:0] BIN_sig
	.HEX(HEX0) 	// output [0:6] HEX_sig
);
binary2hex ten
(
	.BIN(tens) ,	// input [3:0] BIN_sig
	.HEX(HEX1) 	// output [0:6] HEX_sig
);
binary2hex hundered
(
	.BIN(hundreds) ,	// input [3:0] BIN_sig
	.HEX(HEX2) 	// output [0:6] HEX_sig
);
assign HEX3 = ~SW7[7];


endmodule
