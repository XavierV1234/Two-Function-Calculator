module RippleCarryAdderStructural ( //name the module
	input [7:0] A, B,
	input add_subtract, //declare input ports
	output [7:0] S, //declare output ports for sum
	output Cout, Neg, Ovr, Zero); //declare carry-out port
	
	wire [8:0] C; //declare internal nets
  assign C[0] = add_subtract;
	assign Cout = C[8]; //rename carry-out port
	assign Neg = S[7];
	assign Ovr = Cout ^ C[7];
	assign Zero = ~(S[7]|S[6]|S[5]|S[4]|S[3]|S[2]|S[1]|S[0]);
	
//instantiate the full adder module for each stage of the ripple carry adder/subtractor
	Fabehav s0 (A[0], B[0]^C[0], C[0], S[0], C[1]); //stage 0
	Fabehav s1 (A[1], B[1]^C[0], C[1], S[1], C[2]); //stage 1
	Fabehav s2 (A[2], B[2]^C[0], C[2], S[2], C[3]); //stage 2
	Fabehav s3 (A[3], B[3]^C[0], C[3], S[3], C[4]); //stage 3
	Fabehav s4 (A[4], B[4]^C[0], C[4], S[4], C[5]); //stage 4
	Fabehav s5 (A[5], B[5]^C[0], C[5], S[5], C[6]); //stage 5
	Fabehav s6 (A[6], B[6]^C[0], C[6], S[6], C[7]); //stage 6
	Fabehav s7 (A[7], B[7]^C[0], C[7], S[7], C[8]); //stage 7
endmodule
