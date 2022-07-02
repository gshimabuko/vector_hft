// Testbench top
module tb;
logic clock;
logic reset;
logic trigger_write_enable;
logic trigger_side;
logic trigger_direction;
logic [7:0] trigger_price;
logic [7:0] bid_price;
logic [7:0] ask_price;
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
//...
end
endmodule
