module FiftyNineSec //top level
(
input clock, reset, OffToggle,
output [0:6] Aout, Bout
);
wire [3:0] A, B;
wire one, sec0, sec1, clk;
wire [3:0] count5, count10;
wire [9:0] count1000L, count1000M;
//instantiations
onehertz OneHzClock_inst
(
.clock(clk) , // input 50-MHz clock
.reset(reset) , // input reset
.OneHz(one) // output OneHz clock k0
);
divideXn #(4'd10, 4'd4) div10
(
.CLOCK(one) , // input 10MHz clock
.CLEAR(reset) , // input reset
.OUT(sec0) , // output 1-MHz clock
.COUNT(B) // output [3:0] count bits
);
binary2hex seconds_low_display
(
.BIN(B) , // input [3:0] seconds low count
.HEX(Bout) // output [0:6] low seconds display
);
divideXn #(3'd6, 3'd3) div6 //module divideXn needs to be included only once in the project directory since it’s parameterized
(
.CLOCK(sec0), // input 50MHz clock
.CLEAR(reset) , // input reset
.OUT(sec1), // output 10-MHz clock
.COUNT(A) // output [3:0] count bits
);
binary2hex seconds_high_display
(
.BIN(A) , // input [3:0] high seconds count
.HEX(Aout) // output [0:6] high seconds display
);
OnOffToggle OnoffToggle_inst
  (
  .OnOff(OffToggle),
  .IN(clock),
  .OUT(clk)
  );

endmodule
