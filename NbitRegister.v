module NbitRegister #(parameter N = 4) //declare default value for N
    ( input [N-1:0] D, //declare N-bit data input
    input CLK, CLR, CE, //declare clock, clear, and clock enable inputs
    output logic [N-1:0] Q //declare N-bit data output
    );
        always_ff @ (posedge CLK, negedge CLR) //detect change of clock or clear
            begin
                if (CLR==1'b0) Q <= 0; //register loaded with all 0’s
                             else Q <= Q; // hold current values if not enabled
        end
endmodule 