module DigitalTicketCounter(
	input clk,
	input reset,
	input tk5,
	input tk10,
	input tk20,
	input [2:0] select,
	input buy,
	input pricec,
	input stockc,
	input quantc,
	input [3:0] password,
    output reg [2:0] quant,
	output reg [2:0] price0,
	output reg [2:0] price1,
	output reg [2:0] price2,
	output reg [2:0] stock0,
	output reg [2:0] stock1,
	output reg [2:0] stock2,
	output reg led = 0,
    output [3:0] mhuns,
    output [3:0] mtens,
    output [3:0] mones,
    output [3:0] ctens,
    output [3:0] cones
	);
	
	reg tk5_prev, tk10_prev, tk20_prev;
	reg buy_prev, pricec_prev, quantc_prev, stockc_prev;
    reg [7:0] money=0;
    reg [5:0] cost=0;	

	
	reg [3:0] pass = 4'b1011;
	
    Binary2BCD B1(money, mhuns, mtens, mones);
    Binary2BCD1 B2(cost, ctens, cones);

	
	initial
	begin
		price0 = 3'd2;
		price1 = 3'd4;
		price2 = 3'd5;
		stock0 = 3'd7;
		stock1 = 3'd7;
		stock2 = 3'd7;
		quant = 3'd0;
		quantc_prev = 1'b1;
	end
  
  
	
	always @(posedge clk)
	begin
		tk5_prev <= tk5;
		tk10_prev <= tk10;
		tk20_prev <= tk20;
		buy_prev <= buy;
		pricec_prev <= pricec;
		quantc_prev <= quantc;
		stockc_prev <= stockc;
		
		case (select)
		3'b001:
			cost <= price0*quant;
		3'b010:
			cost <= price1*quant;
		3'b100:
			cost <= price2*quant;
		default:
			cost <= 6'd0;
		endcase
		
		if (quantc_prev == 1'b0 && quantc == 1'b1)
		begin
			quant <= quant + 3'd1;
		end
		
		else if (reset == 1)
		begin
			money <= 1'b0;
			quant <= 3'b000;
		end
		else if (tk5_prev == 1'b0 && tk5 == 1'b1)
			money <= money + 8'd5;
		
		else if (tk10_prev == 1'b0 && tk10 == 1'b1)
			money <= money + 8'd10;
		
		else if (tk20_prev == 1'b0 && tk20 == 1'b1)
			money <= money + 8'd20;
			
		else if (buy_prev == 1'b0 && buy == 1'b1)
			case (select)
				3'b001:
					if (money >= cost && stock0 >= quant)
					begin
						stock0 <= stock0 - quant;
						money <= money - cost;
						cost <= 6'd0;
						quant <= 3'd0;
					end
					
				3'b010:	
					if (money >= cost && stock1 >= quant)
					begin
						stock1 <= stock1 - quant;
						money <= money - cost;
						cost <= 6'd0;
						quant <= 3'd0;
					end
					
				3'b100:
					if (money >= cost && stock2 >= quant)
					begin
						stock2 <= stock2 - quant;
						money <= money - cost;
						cost <= 6'd0;
						quant <= 3'd0;
					end
			endcase
		
		else if (password == pass)
          begin
			led <= 1'b1;
			
			if (stockc_prev == 1'b0 && stockc == 1'b1)
				case (select)
				3'b001: stock0 <= stock0 + 3'd1;
				3'b010: stock1 <= stock1 + 3'd1;
				3'b100: stock2 <= stock2 + 3'd1;
				endcase
				
			else if (pricec_prev == 1'b0 && pricec == 1'b1)
			
				case (select)
				3'b001: price0 <= price0 + 3'd1;
				3'b010: price1 <= price1 + 3'd1;
				3'b100: price2 <= price2 + 3'd1;
				endcase
          end
			
		else if (password != pass)
			led <= 1'b0;

	end
endmodule
		



