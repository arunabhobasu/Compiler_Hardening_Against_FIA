`timescale 1ns/1ps

module RSA_tb;

reg clk;
reg start;
wire finished;

RSA_binary_v2 DUT(
	.clk(clk),
	.start(start),
	.finished(finished)
);

always #5 clk = ~clk;

initial
begin
	$dumpfile("input.vcd");
	$dumpvars(1, DUT.clk, DUT.start);
end

initial
begin
	clk = 1;
	start = 0;
	
	#10 start = 1;
	#1000 $stop;
end

endmodule
