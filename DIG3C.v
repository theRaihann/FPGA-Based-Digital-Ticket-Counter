module DIG3C(
	input [3:0] in1,
	input [3:0] in2,
	input [3:0] in3,
	input clk,
	output reg [2:0] cathode,
	output reg [6:0] seg
	);
	
	integer count;
	wire [6:0] seg1, seg2, seg3;
	
	BCD27segC disp1(in1, seg1);
	BCD27segC disp2(in2, seg2);
	BCD27segC disp3(in3, seg3);
	
	initial
		count = 0;
	
	always @(posedge clk)
	begin
		if (count == 165000)
		begin
			cathode = 3'b110;
			seg <= seg1; 
		end
		
		else if(count == 330000)
		begin
			cathode = 3'b101;
			seg <= seg2;
		end
		
		else if(count == 495000)
		begin
			cathode = 3'b011;
			seg <= seg3;
			count = 0;
		end
		
			count <= count + 1;
		
	end
endmodule
		
