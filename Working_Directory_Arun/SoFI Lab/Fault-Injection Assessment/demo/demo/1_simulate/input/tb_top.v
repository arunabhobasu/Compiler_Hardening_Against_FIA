

// $ vcs done_fanin.v tb_top.v -v ./saed32nm.v -R -debug_all -gui +v2k -l log.txt
// $ dve -vpd wave.vcd.vpd &

`timescale 1ns / 1ps

module test;

reg		clk;
reg		rst;
reg		kld;
wire		done;
integer		n;

//initial begin
//	$dumpfile("fan_in.vcd");
//	$dumpvars(1, u0.done_reg.Q, u0.dcnt_reg_0_.Q, u0.dcnt_reg_1_.Q, u0.dcnt_reg_2_.Q, u0.dcnt_reg_3_.Q);
//end

initial begin
	$dumpfile("input.vcd");
	$dumpvars(1, u0.clk, u0.rst, u0.ld);
end


initial
   begin
	$display("\n\n");
	$display("*****************************************************");
	$display("* AES Test bench ...");
	$display("*****************************************************");
	$display("\n");
`ifdef WAVES
  	$shm_open("waves");
	$shm_probe("AS",test,"AS");
	$display("INFO: Signal dump enabled ...\n\n");
`endif

	kld = 0;
	clk = 0;
	rst = 0;
	repeat(4)	@(posedge clk);
	rst = 1;
	repeat(20)	@(posedge clk);

	$display("");
	$display("");
	$display("Started random test ...");


for(n=0;n<4;n=n+1)
   begin
	@(posedge clk);
	#1;
	kld = 1;
	@(posedge clk);
	#1;
	kld = 0;
	@(posedge clk);

	//while(!done)	@(posedge clk);
	repeat(11) @(posedge clk);
	@(posedge clk);
	#1;
   end


	$display("");
	$display("");
	$display("Test Done.");
	$display("");
	$display("");
	repeat(10) @(posedge clk);
	$finish;
end


always #10 clk = ~clk;

done_fanin u0(
	.clk(		clk		),
	.rst(		rst		),
	.ld(		kld		),
	.done(		done		)
	);

endmodule


