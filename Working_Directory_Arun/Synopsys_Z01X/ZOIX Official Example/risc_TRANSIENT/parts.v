/*******************************************************************************
* (c) 2016 Synopsys, Inc.
*
* This file and it's contents are proprietary to Synopsys, Inc. and may 
* only be used pursuant to the terms and conditions of a written license 
* agreement with Synopsys, Inc. All other use, reproduction, modification, 
* or distribution of this file is stricly prohibited.
*******************************************************************************/

`timescale 100 ps / 100 ps

module alu (alu_out,zero,opcode,data,accum,clock);
  input [7:0]  data,accum;
  input [2:0]  opcode;
  input        clock;
  output [7:0] alu_out;
  output       zero;

  reg [7:0]    alu_out;
  reg          zero;

  initial
	zero = 0;

  always @(negedge clock)
    case (opcode)
      3'h0: alu_out = accum;
      3'h1: alu_out = accum;
      3'h2: alu_out = accum + data;
      3'h3: alu_out = accum & data;
      3'h4: alu_out = accum ^ data;
      3'h5: alu_out = data;
      3'h6: alu_out = accum;
      3'h7: alu_out = accum;
      default: $display("invalid opcode");
    endcase

  always @(accum)
    if (!accum)
      zero = 1;
    else
      zero = 0;

endmodule

module clocks(fetch,clk_2,clk);
  output fetch,clk,clk_2;
  reg    fetch,clk_2;
  reg    start;

  nor #10 (clk, clk, start);

  initial
   begin
     fetch = 0;
     clk_2 = 0;
     start = 1;
     #20 start = 0;
   end

  always @(negedge clk)
    clk_2 = ~clk_2;

  always @(posedge clk_2)
    fetch = ~fetch;

endmodule

module counter(cnt,clk,data,rst,le);
input clk,rst,le;
input [5:1] data;
output [5:1] cnt;

wire [5:1] data,cnt,mcnt,next_cnt;

wire [5:2] qb;

dff d1(cnt[1],next_cnt[1],clk,mcnt[1],rst),
    d2(cnt[2],qb[2],clk,mcnt[2],rst),
    d3(cnt[3],qb[3],clk,mcnt[3],rst),
    d4(cnt[4],qb[4],clk,mcnt[4],rst),
    d5(cnt[5],qb[5],clk,mcnt[5],rst);

mux m1(mcnt[1],data[1],next_cnt[1],le),
    m2(mcnt[2],data[2],next_cnt[2],le),
    m3(mcnt[3],data[3],next_cnt[3],le),
    m4(mcnt[4],data[4],next_cnt[4],le),
    m5(mcnt[5],data[5],next_cnt[5],le);

xor x2(next_cnt[2],cnt[1],cnt[2]);

and a3(an3,cnt[1],cnt[2]);
xor x3(next_cnt[3],an3,cnt[3]);

and a4(an4,cnt[1],cnt[2],cnt[3]);
xor x4(next_cnt[4],an4,cnt[4]);

and a5(an5,cnt[1],cnt[2],cnt[3],cnt[4]);
xor x5(next_cnt[5],an5,cnt[5]);

endmodule

module mux(muxout,in1,in0,sel);
input in1,in0,sel;
output muxout;

not n1(selb,sel);

and a1(selh,in1,sel),
    a2(sell,in0,selb);
or  o1(muxout,selh,sell);

endmodule

module decoder(load_accum,mem_read,mem_wr,inc_pc,load_pc,load_ir,
		opcode,fetch,zero,clk,clk_2, not_reset);
input fetch,zero,clk,clk_2, not_reset;
input [2:0] opcode;
output load_accum,mem_read,mem_wr,inc_pc,load_pc,load_ir;

wire [2:0] opcode;
reg load_accum,mem_read,mem_wr,inc_pc,load_pc,load_ir;
parameter cycle = 20;

always @(negedge fetch)
      begin   // reset active low
	mem_read = 0;
	inc_pc = 1;
	load_ir = 0;
	@(posedge clk) begin
		if (opcode >= 3'h2 && opcode <= 3'h5)
		     mem_read = 1;
	        inc_pc = 0;
                end
	@(negedge clk_2)
   	   case (opcode)
	       3'h0: if (not_reset) $stop;
	       3'h1: if (zero) inc_pc = 1;
	       3'h2: load_accum = 1;
	       3'h3: load_accum = 1;
	       3'h4: load_accum = 1;
	       3'h5: load_accum = 1;
	       3'h6: ;
	       3'h7: load_pc = 1;
   	       default: begin
		     $display("bad opcode");
		     $stop;
		     end
   	   endcase
	@(posedge clk)
		if (opcode == 3'h6) mem_wr = 1;
		if (opcode == 3'h7) inc_pc = 1;
     end

always @(posedge fetch)
      begin  // reset active low
	inc_pc = 0;
	load_accum = 0;
	load_pc = 0;
	mem_wr = 0; 
	mem_read = 0;
	@(posedge clk) mem_read = 1;
	@(negedge clk_2) load_ir = 1;
	end


initial
    begin
	load_accum = 0;
	load_pc = 0;
	mem_wr = 0; 
	mem_read = 0;
	inc_pc = 0;
	load_ir = 0;
   end

endmodule

module dff(q,qb,clk,d,rst);
input d,clk,rst;
output q,qb;

dflop d1(q,d,clk,rst);
not   n1(qb,q);

endmodule

primitive dflop(q,d,clk,rst);
input d,clk,rst;
output q;
reg q;

table
//	d	clk	rst	: q_old : q_new
	?	?	0	:   ?   :  0;
	?	?	x	:   0   :  0;
	0	(01)	1	:   ?   :  0;
	1	(01)	1	:   ?   :  1;
	?	(10)	1	:   ?   :  -;
	*	?	?	:   ?   :  -;
	?	?	*	:   ?   :  -;
endtable
endprimitive
module mem(data,addr,read,write);
input read,write;
input [4:0] addr;

inout [7:0] data;

reg [7:0] memory [0:31];

assign data = (read) ? memory[addr] : 8'bz;

always @(posedge write)
	memory[addr] = data;

task dumpmem;
  reg [5:0] i;
  begin 
    for (i = 0; i < 32; i = i + 1)
      begin
        if (!(i & 15)) $display; 
        $write("%h:%h  ", i, memory[i]);
      end
    $display;
    $stop(0);
  end
endtask

initial 
        $readmemb("pgm.txt",memory);     // fibonacci program
//      $readmemb("cput1.txt", memory);  // debugging routine

endmodule

module mux2x5 (z, a, b, sel);
  output [4:0] z;
  input  [4:0] a, b;
  input        sel;

  assign z = sel ? b : a;

endmodule

module register(r,clk,data,ena,rst);
input clk,ena,rst;
input [8:1] data;
output [8:1] r;

wire [8:1] data, r, rb ;

and a1(load,clk,ena);
dff d1(r[1],rb[1],load,data[1],rst),
    d2(r[2],rb[2],load,data[2],rst),
    d3(r[3],rb[3],load,data[3],rst),
    d4(r[4],rb[4],load,data[4],rst),
    d5(r[5],rb[5],load,data[5],rst),
    d6(r[6],rb[6],load,data[6],rst),
    d7(r[7],rb[7],load,data[7],rst),
    d8(r[8],rb[8],load,data[8],rst);

endmodule

/* RESETER

This module will let the reset signal go low any time a request is made,
but it won't let it go high until the middle of the fetch low cycle.

*/

module reseter (reset, reset_req, fetch, clk_2);
input reset_req, fetch, clk_2;
output reset;
reg reset;

always wait (reset_req == 0)
  begin
   reset = 0;
   wait (reset_req == 1);
  end

always @ (posedge reset_req)
	@  (negedge fetch)
	  @ (negedge clk_2)
	     reset = 1;

endmodule

module tricon (o, i, ctl);
  output [7:0] o;
  input  [7:0] i;
  input        ctl;

  assign o = ctl ? i : 8'bz;

endmodule
