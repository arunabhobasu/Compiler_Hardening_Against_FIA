/*******************************************************************************
* (c) 2017 Synopsys, Inc.
*
* This file and it's contents are proprietary to Synopsys, Inc. and may 
* only be used pursuant to the terms and conditions of a written license 
* agreement with Synopsys, Inc. All other use, reproduction, modification, 
* or distribution of this file is stricly prohibited.
*******************************************************************************/

module strobe;

  initial
    $fs_inject;


  integer cmp;

  initial begin
	$dumpfile("ff.vcd");
	$dumpvars(1, done_fanin.done, done_fanin.ld, done_fanin.clk, done_fanin.dcnt_reg_0_.Q, done_fanin.dcnt_reg_0_.QN, done_fanin.dcnt_reg_1_.Q, done_fanin.dcnt_reg_1_.QN, done_fanin.dcnt_reg_2_.Q, done_fanin.dcnt_reg_2_.QN, done_fanin.dcnt_reg_3_.Q, done_fanin.dcnt_reg_3_.QN);
  end
/*
* Whenever the fetch signal transitions to 1'b0, compare the output of the
* device. If it shows a difference (GM-FM are different), set the status to ON or
* PN (if there is an X involved).  Continue to simulate the fault.  This 
* indicates the fault is dangerous and can cause the device to fail.
*/
  initial
    begin
      forever @(posedge done_fanin.ld)
        begin
          @(posedge done_fanin.clk);
	  @(posedge done_fanin.clk);
	  @(posedge done_fanin.clk);
	  #5000
          // Compare alu_out signal in GM and FM
          cmp = $fs_compare(done_fanin.done);
          if (1 == cmp)
            begin
              // cmp == 1 indicates diff in GM and FM signals
              $fs_set_status("DD", done_fanin.done);
              break;
            end
          else if (2 == cmp)
            begin
              // cmp == 2 indicates diff in GM and FM signals with X
              $fs_set_status("PD", done_fanin.done);
              break;
            end
        end
    end

/*
* At the end of the simulation, compare the memory inside the device.  If a 
* difference is observed, set the status to observed detected and drop the fault
* from simulation.  If the status was not previously observed, set it to 
* diagnosed, but not observed.
*/
  
   

endmodule
