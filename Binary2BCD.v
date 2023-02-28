module Binary2BCD(
	input [7:0] binary,
	output reg [3:0] huns,
	output reg [3:0] tens,
	output reg [3:0] ones
	);
	
	reg [7:0] bcd_data = 0;
	
	always @(binary)
	begin
		bcd_data = binary;
		huns = bcd_data/100;
		bcd_data = bcd_data%100;
		tens = bcd_data/10;
		ones = bcd_data%10;
		
	end
endmodule
