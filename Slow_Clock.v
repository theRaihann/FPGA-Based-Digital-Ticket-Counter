module Slow_Clock(
	input clk_in,
	output reg clk 
	);
	
	integer count;
	
	initial 
	begin
		count = 0;
		clk = 0;
	end
	
		
	always @(posedge clk_in)
	begin
		count <= count+1;
      if (count == 3125000)
		begin
			count<=0;
			clk = ~clk;
		end
	end
endmodule 
