module Project(
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
	output [2:0] mcathode,
	output [6:0] mdisp,
	output [2:0] ccathode,
	output [6:0] cdisp,
	output [2:0] prcathode,
	output [6:0] prdisp,
	output [2:0] stcathode,
	output [6:0] stdisp,
	output led
	);
	
	wire sclk, deb_reset, deb_tk5, deb_tk10, deb_tk20, deb_buy, deb_pricec, deb_quantc, deb_stockc; 
	wire [3:0] mhuns, mtens, mones;
	wire [3:0] ctens, cones;
	wire [2:0] quant;
	wire [2:0] price0;
	wire [2:0] price1;
	wire [2:0] price2;
	wire [2:0] stock0;
	wire [2:0] stock1;
	wire [2:0] stock2;
	wire [3:0] quant_, price0_, price1_, price2_, stock0_, stock1_, stock2_;
	assign quant_ = {1'b0, quant};
	assign price0_ = {1'b0, price0};
	assign price1_ = {1'b0, price1};
	assign price2_ = {1'b0, price2};
	assign stock0_ = {1'b0, stock0};
	assign stock1_ = {1'b0, stock1};
	assign stock2_ = {1'b0, stock2};
	
	Slow_Clock s1(clk, sclk);
	Debounce d1(reset, sclk, deb_reset);
	Debounce d2(tk5, sclk, deb_tk5);
	Debounce d3(tk10, sclk, deb_tk10);
	Debounce d4(tk20, sclk, deb_tk20);
	Debounce d5(buy, sclk, deb_buy);
	Debounce d6(pricec, sclk, deb_pricec);
	Debounce d7(quantc, sclk, deb_quantc);
	Debounce d8(stockc, sclk, deb_stockc);
	
	DigitalTicketCounter DTC(clk, deb_reset, deb_tk5, deb_tk10, deb_tk20, select, deb_buy, deb_pricec, deb_stockc, deb_quantc, password, quant, price0, price1, price2, stock0, stock1, stock2, led, mhuns, mtens, mones, ctens, cones);
	
	DIG3C D1(mones, mtens, mhuns, clk, mcathode, mdisp);
	DIG3A D2(cones, ctens, quant_, clk, ccathode, cdisp);
	DIG3A D3(price0_, price1_, price2_, clk, prcathode, prdisp);
	DIG3A D4(stock0_, stock1_, stock2_, clk, stcathode, stdisp);
	
endmodule


































