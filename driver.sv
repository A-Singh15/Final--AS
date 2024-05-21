class driver;
    virtual ac_if.test acif;
    transaction tr;
    mailbox mbx, rtn, mbx_scb;

    function new(mailbox mbx, rtn, mbx_scb, input virtual ac_if.test acif);
        this.mbx = mbx;
        this.rtn = rtn;
        this.mbx_scb = mbx_scb;
        this.acif = acif;
        tr = new();
    endfunction

    task run();
        // Apply reset
        acif.cb.rst <= 1;
        repeat (2) @(acif.cb);
        acif.cb.rst <= 0;

        // Check reset operation
        if (acif.cb.sum == 0)
            $display("Reset successful.");
        else
            $display("Reset failed.");

        // Initial transaction to set up the initial sum
        @(acif.cb);
        tr = new();
        tr.in = 8'h00;  // Initial input value
        tr.sum = acif.cb.sum;  // Initial sum value
        mbx_scb.put(tr);  // Send initial transaction to the scoreboard

        // Main driving loop
        while (1) begin
            mbx.get(tr);
            // Acknowledge transaction to generator
            rtn.put(tr);
            // Send transaction to scoreboard
            mbx_scb.put(tr);
            // Drive the DUT interface
            acif.cb.in <= tr.in;
            @(acif.cb);
        end
    endtask : run

    task wrap_up();
        wait (acif.sum == 16'hFFFF);
        @acif.clk;
        $display("***Sum output saturated to 16'hFFFF; Finishing simulation***");
        $finish;
    endtask : wrap_up
endclass
