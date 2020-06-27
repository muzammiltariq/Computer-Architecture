module tb();

reg clk, reset;

Processor Process
(
	.clk(clk),
	.reset(reset)
);


initial
	begin
	clk = 0;
	reset = 0;
	#5;
	
	reset = 1;
	#5;
	
	reset = 0;
	#3;
	
	clk = ~clk;
	#3;
	
	#2;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;	
	end	
endmodule