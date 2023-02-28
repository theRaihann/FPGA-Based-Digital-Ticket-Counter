module Debounce(
	input pb, clk_in,
	output db_pb
	);
	
	wire Q1, Q2, Q2bar;
	
	D_FF d1(clk_in, pb, Q1);
	D_FF d2(clk_in, Q1, Q2);
	
	assign Q2bar = ~Q2;
	assign db_pb = Q1 & Q2bar;
endmodule