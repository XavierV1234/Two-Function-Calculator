
module AU8 (
	input [7:0] X, //declare data inputs
	input InA, InB, Out, Clear, Add_Subtract, //declare control inputs
	output [7:0] Rout, //declare result output
	output [3:0] CCout, //declare condition code output
	output [0:6] HEX2, HEX1, HEX0,
	output Cout, Ovr, Zero, Neg); //declare seven-segment outputs
//Declare internal nodes
	wire [7:0] Aout, Bout, R; //declare register outputs
	//wire Cout, Ovr, ZERO, NEG; //declare condition codes
//Make internal node assignments

//Instantiate registers
NbitRegister #(4'd8) regA //8-bit register
(
.D(X) , // Register A input
.CLK(InA) , // Register A load
.CLR(Clear) , // Register A clear
.Q(Aout) // Register A output
);

NbitRegister #(4'd8) regb //8-bit register
(
.D(X) , // Register A input
.CLK(InB) , // Register A load
.CLR(Clear) , // Register A clear
.Q(Bout) // Register A output
);

NbitRegister #(3'd4) regCC //4-bit register
(
.D({Ovr, Cout, Neg, Zero}) , // Register CC input
.CLK(Out) , // Register CC load
.CLR(Clear) , // Register CC clear
.Q(CCout) // Register CC output
);

NbitRegister #(4'd8) regR //8-bit register
(
.D(R) , // Register A input
.CLK(Out) , // Register A load
.CLR(Clear) , // Register A clear
.Q(Rout) // Register A output
);

//Instantiate full adders
RippleCarryAdderStructural RippleCarryAdderStructural_inst
(
	.A(Aout) ,	// input [7:0] A_sig
	.B(Bout) ,	// input [7:0] B_sig
	.add_subtract(Add_Subtract) ,	// input  add_subtract_sig
	.S(R) ,	// output [7:0] S_sig
	.Cout(Cout) ,	// output  Cout_sig
	.Neg(Neg) ,	// output  Neg_sig
	.Ovr(Ovr) ,	// output  Ovr_sig
	.Zero(Zero) 	// output  Zero_sig
);


//Instantiate bin2sev decoders
binary2hex Rout1
(
.BIN(Rout[3:0]),// input [3:0] seconds low count
.HEX(HEX0) // output [0:6] low seconds display
);
binary2hex Rout2
(
.BIN(Rout[7:4]), // input [3:0] seconds low count
.HEX(HEX1) // output [0:6] low seconds display
);
binary2hex Ccout
(
.BIN(CCout), // input [3:0] seconds low count
.HEX(HEX2) // output [0:6] low seconds display
);


endmodule
