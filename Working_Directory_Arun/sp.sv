  //--------------------------------------------------------------------
  //  Security Property 2:  No BEQ‑instruction skipping
  //
  //  When a BEQ is in the fetch stage (detected via opcode 1100011
  //  and funct3 000), the next fetch cycle in the fault‑machine must
  //  be identical to the good‑machine.  A mismatch means the BEQ was
  //  skipped or corrupted, so we raise a Dropped‑Detect (DD) status.
  //--------------------------------------------------------------------
  initial begin : sp2_no_beq_skip
    integer beq_cmp;

    // Wait until the fault has been injected (same offset as SP1)
    #20;
    #(CLK_PERIOD*6);
    #(CLK_PERIOD/2);

    forever begin
      @(posedge top.clk);

      // Detect a BEQ in the instruction register / fetch stage
      if (top.instruction[6:0]  == 7'b1100011 &&   // opcode for all branches
          top.instruction[14:12] == 3'b000) begin  // funct3 = 000 → BEQ

        // Advance exactly one clock to the instruction *after* BEQ
        @(posedge top.clk);

        // Compare the fetched instruction words in GM vs FM
        beq_cmp = $fs_compare(top.instruction);

        // If they differ, the BEQ was skipped or corrupted → DD
        if (beq_cmp == 1) begin
          $fs_set_status("DD", top.instruction);
        end
      end
    end
  end
