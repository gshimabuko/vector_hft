//
// Simple trigger:
// Store a price trigger and compare it against a stream of market prices to
// check whether market conditions satisfy the trigger. Whether a price is
// more aggressive or less aggressive than another price depends on whether
// the price is a bid price or an ask price. For a bid price, a higher price
// is a more aggressive price and a lower price is a less aggressive price.
// For an ask price, a lower price is a more aggressive price and a higher
// price is a less aggressive price. Triggers are expressed as follows: is
// the market price for trigger_side more or less aggressive than the
// trigger_price? For example: If trigger_side indicates bid,
// trigger_direction indicates more aggressive, and trigger_price is 100,
// then trigger_satisified should be true when bid_price is greater than 100.
//
// clock: during a positive edge, store trigger_price, trigger_side and
// trigger_direction to become active next cycle if trigger_write_enable,
// compare market price to active trigger_price, trigger_side and
// trigger_direction to determine output trigger_satisfied.
// reset: If reset is 1 during a positive clock edge, store 0 in
// trigger_satisfied for next cycle and treat trigger_price, trigger_side
// and trigger_direction as if they were 0 and trigger_write_enable as if it
// were 1 this cycle.
//
// trigger_write_enable: 0 = do not store trigger, 1 = store trigger.
// trigger_side: 0 = bid, 1 = ask.
// trigger_direction: 0 = less aggressive, 1 = more aggressive. A higher bid
// is more aggressive. A lower ask is more aggressive.
// trigger_price: a reference price to compare against in the trigger.
//
// bid_price: input market highest bid price.
// ask_price: input market lowest ask price.
//
// trigger_satisfied: 1 if the market price compares to the trigger_price as
// specified in trigger_side and trigger_direction, and 0 otherwise.
//
module trigger (
input logic clock,
input logic reset,
input logic trigger_write_enable,
input logic trigger_side,
input logic trigger_direction,
input logic[7:0] trigger_price,

input logic [7:0] bid_price,
input logic [7:0] ask_price,
output reg trigger_satisfied = 0
);
//Fill in the implementation of trigger here.
parameter 	IDLE = 2'b00,
			READ_TRIGGER = 2'b11;
			BID = 2'b01;
			ASK = 2'b10;
			
reg [1:0] c_state, n_state;
reg s_trigger_side;
reg s_trigger_direction;
reg s_trigger_write_enable;
reg [7:0] s_trigger_price;

always @ (posedge(clk), posedge(rst))
begin
	if(rst)
	begin
		c_state <= IDLE;
	end else
		c_state <= n_state;
end

always @(c_state, s_trigger_write_enable, trigger_side)
	case (c_state)
		IDLE			: 	if(!s_trigger_write_enable) 	
								n_state = IDLE;
							else						n_state = READ_TRIGGER;
		READ_TRIGGER	:	if(!s_trigger_write_enable && trigger_direction = 1'b0)
								n_state = BID;
							else if(!s_trigger_write_enable && trigger_direction = 1'b1)
								n_state = ASK;
							else
								n_state = READ_TRIGGER;
		BID				:	if(s_trigger_write_enable) 	
								n_state = READ_TRIGGER;
							else						
								n_state = BID;
		ASK				:	if(s_trigger_write_enable) 	
								n_state = READ_TRIGGER;
							else						
								n_state = ASK;
		endcase
end

always @(posedge(clk))

// reset: If reset is 1 during a positive clock edge, store 0 in
// trigger_satisfied for next cycle and treat trigger_price, trigger_side
// and trigger_direction as if they were 0 and trigger_write_enable as if it
// were 1 this cycle.
	if (rst == 0)
	begin
		trigger_satisfied = 1'b0;
		s_trigger_side <= 1'b0;
		s_trigger_direction <= 1'b0;
		s_trigger_write_enable <= 1'b1;
		
		s_trigger_price <= 8'b0;
		trigger_satisfied < = 1'b0;
	end else
	begin
		s_trigger_write_enable <= trigger_write_enable;
		case (n_state)
			IDLE :	
				s_trigger_side <= s_trigger_side;
				s_trigger_direction <= s_strigger_direction;BI
				s_trigger_write_enable <= s_trigger_write_enable;
				s_trigger_price <= s_trigger_price;
				
				trigger_satisfied <= 1'b0;
			
			READ_TRIGGER :
				s_trigger_side <= trigger_side;
				s_trigger_direction <= strigger_direction;
				s_trigger_write_enable <= trigger_write_enable;
				s_trigger_price <= trigger_price;
				
				trigger_satisfied <= 1'b0;
				
			BID:	
				s_trigger_side <= s_trigger_side;
				s_trigger_direction <= s_strigger_direction;
				s_trigger_write_enable <= s_trigger_write_enable;
				s_trigger_price <= s_trigger_price;
				
				if(bid_price > s_trigger_price)
					trigger_satisfied <= s_trigger_direction;
				else
					trigger_satisfied <= !(s_strigger_direction); 
			ASK:
				s_trigger_side <= s_trigger_side;
				s_trigger_direction <= s_strigger_direction;
				s_trigger_write_enable <= s_trigger_write_enable;
				s_trigger_price <= s_trigger_price;
				
				if(bid_price > s_trigger_price)
					trigger_satisfied <= !(s_strigger_direction);
				else
					trigger_satisfied <= s_trigger_direction;
			endcase
			
// Simple trigger:
// Store a price trigger and compare it against a stream of market prices to
// check whether market conditions satisfy the trigger. Whether a price is
// more aggressive or less aggressive than another price depends on whether
// the price is a bid price or an ask price. 

// For a bid price, a higher price
// is a more aggressive price and a lower price is a less aggressive price.

// For an ask price, a lower price is a more aggressive price and a higher
// price is a less aggressive price. 

// Triggers are expressed as follows: is
// the market price for trigger_side more or less aggressive than the
// trigger_price? For example: If trigger_side indicates bid,
// trigger_direction indicates more aggressive, and trigger_price is 100,
// then trigger_satisified should be true when bid_price is greater than 100.
	end else
	begin
	end
end
endmodule
