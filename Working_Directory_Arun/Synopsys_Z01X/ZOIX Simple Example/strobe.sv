/*******************************************************************************
* (c) 2017 Synopsys, Inc.
*
* This file and it's contents are proprietary to Synopsys, Inc. and may 
* only be used pursuant to the terms and conditions of a written license 
* agreement with Synopsys, Inc. All other use, reproduction, modification, 
* or distribution of this file is stricly prohibited.
*******************************************************************************/

module strobe;

  parameter CLK_PERIOD = 10000;	//ps

  initial
    $fs_inject;


  integer FSM0,FSM1,FSM2;

  initial begin
	$dumpfile("ff.vcd");
	$dumpvars(1,
	RSA_binary_v2.clk,
	RSA_binary_v2.start,
	RSA_binary_v2.round_index_reg_0_.Q,
	RSA_binary_v2.round_index_reg_1_.Q,
	RSA_binary_v2.round_index_reg_2_.Q,
	RSA_binary_v2.round_index_reg_3_.Q,
	RSA_binary_v2.FSM_reg_0_.Q,
	RSA_binary_v2.FSM_reg_1_.Q,
	RSA_binary_v2.FSM_reg_2_.Q
	);
  end
/*
* Whenever the fetch signal transitions to 1'b0, compare the output of the
* device. If it shows a difference (GM-FM are different), set the status to ON or
* PN (if there is an X involved).  Continue to simulate the fault.  This 
* indicates the fault is dangerous and can cause the device to fail.
*/

  initial
    begin
      //forever @(posedge RSA_binary_v2.start)
        //begin
		#(CLK_PERIOD*7)
		// Wait half more cycle to ensure the fault is injected
		#(CLK_PERIOD/2)

			// The compare result is 0 if same in two models, otherwise 1
			//FSM2 = $fs_compare(RSA_binary_v2.FSM_reg_2_.Q);
			//FSM1 = $fs_compare(RSA_binary_v2.FSM_reg_1_.Q);
			FSM0 = $fs_compare(RSA_binary_v2.FSM_reg_0_.Q);
			if (FSM0==1)	//FSM_reg_0_.Q value diff in GM and FM
            begin
				$fs_set_status("DD", RSA_binary_v2.FSM_reg_0_.Q);
				//$fs_set_status("DD", RSA_binary_v2.FSM_reg_1_.Q);
				//$fs_set_status("DD", RSA_binary_v2.FSM_reg_2_.Q);
            end
			
          //else if (2 == cmp)
            //begin
              // cmp == 2 indicates diff in GM and FM signals with X
              //$fs_set_status("PD", done_fanin.done);
              //break;
            //end
        //end
    end

/*
* At the end of the simulation, compare the memory inside the device.  If a 
* difference is observed, set the status to observed detected and drop the fault
* from simulation.  If the status was not previously observed, set it to 
* diagnosed, but not observed.
*/

endmodule
