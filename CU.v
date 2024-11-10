module CU(
input [3:0] value,
input clock, clearA,
output reg reset, loadA, loadB, AddSub, loadR, IUAU, entry,
output slow_clock
);
clockDiv #(.DIV(100000)) clockDiv_inst
(
	.clk(clock) ,	// input  clk_sig
	.clk_out(slow_clock) 	// output  clk_out_sig
);



reg[2:0] state;
reg [2:0]nextState;
parameter S0 = 3'b000, S1 = 3'b001, S2=3'b010, S3= 3'b011, S4 = 3'b100, S5 = 3'b101;

always @ (posedge slow_clock, negedge clearA)
if (clearA == 1'b0) state <= S0;
else state <= nextState;
always @ (state)
case (state)

S0: begin nextState=S1;
	reset=0;
	loadA=0;
	loadB=0;
	loadR=0;
	IUAU=0;
	AddSub=0;
	entry=0;
	end
	
S1: begin reset=1;
	reset=1;
	loadA=0;
	loadB=0;
	loadR=0;
	IUAU=0;
	entry=1;
	if (value == 4'b1010) AddSub = 0;
	if (value == 4'b1011) AddSub = 1;
	if (value == 4'b1010 || value == 4'b1011) nextState = S2;
	else nextState=S1; end

S2: begin nextState=S3;
	reset = 1;
	loadA=1;
	loadB=0;
	loadR=0;
	IUAU=0;
	AddSub=AddSub;
	entry=0;
	end
		
S3: begin 
	reset=1;
	loadA=1;
	loadB=0;
	loadR=0;
	IUAU=0;
	AddSub=AddSub;
	entry = 1;
	if (value == 4'b1111) nextState=S4;
	else nextState=S3;
	end
	

S4: begin nextState=S5;
	reset=1;
	loadA=0;
	loadB=1;
	loadR=0;
	IUAU=0;
	AddSub=AddSub;
	entry= 0;
	end
S5: begin nextState=S5;
	reset=1;
	loadA=0;
	loadB=1;
	loadR=1;
	IUAU=1;
	AddSub=AddSub;
	entry= 1;
	end
default: nextState = S0;
	
endcase 
endmodule
