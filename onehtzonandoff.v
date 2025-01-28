module onehtzonandoff 
(
 input clock, reset, OnOffToggle,
 output OneHz
 );
 wire clk;
 
 onehertz onehertz_inst
 (
 .clock(clk),
 .reset(reset),
 .OneHz(OneHz)
 );
 
OnOffToggle OnoffToggle_inst
  (
  .OnOff(OnOffToggle),
  .IN(clock),
  .OUT(clk)
  );
  
endmodule
