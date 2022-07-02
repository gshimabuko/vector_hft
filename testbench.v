// Testbench top
`timescale 1 ns / 1ps
module tb();
parameter CLK_HALF_PERIOD = 10;
reg clock;
reg reset;
reg trigger_write_enable;
reg trigger_side;
reg trigger_direction;
reg [7:0] trigger_price;
reg [7:0] bid_price;
reg [7:0] ask_price;

wire trigger_satisfied;

trigger trigger_inst (
.clock(clock)
, .reset(reset)
, .trigger_write_enable(trigger_write_enable)
, .trigger_side(trigger_side)
, .trigger_direction(trigger_direction)
, .trigger_price(trigger_price)
, .bid_price(bid_price)
, .ask_price(ask_price)
, .trigger_satisfied(trigger_satisfied)
);

initial begin
clock = 0;
reset = 0;

    #0 trigger_write_enable = 0; trigger_side = 0;
    #2*CLK_HALF_PERIOD
end
always #CLK_HALF_PERIOD clock = ~clock;
endmodule
