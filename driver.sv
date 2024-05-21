class driver;
    virtual ac_if.test acif;
    transaction tr;
    mailbox mbx, rtn, mbx_scb;

    extern function new(mailbox mbx, rtn, mbx_scb, input virtual ac_if.test acif);
    extern virtual task run();
    extern virtual task wrap_up();
endclass : driver

function driver::new(mailbox mbx, rtn, mbx_scb, input virtual ac_if.test acif);
    this.mbx = mbx;
    this.rtn = rtn;
    this.mbx_scb = mbx_scb;
    this.acif = acif;
    tr = new();
endfunction : new

task driver::run();
    // Apply reset
    // Note: Reset should be applied outside the driver
    @(acif.clk);
    // Check reset operation
    if (acif.sum == 0)
        $display("Reset successful.");
    else
        $display("Reset failed.");

    // Main driving loop
    while (1) begin
        mbx.get(tr);
        // Acknowledge transaction to generator
        rtn.put(tr);
        // Send transaction to scoreboard
        mbx_scb.put(tr);
        // Drive the DUT interface
        acif.in <= tr.in;
        @(acif.clk);
        $display("Driving input %0h to DUT at time %0t", tr.in, $time);
    end
endtask : run

task driver::wrap_up();
    wait (acif.sum == 16'hFFFF);
    @acif.clk;
    $display("***Sum output saturated to 16'hFFFF; Finishing simulation***");
    $finish;
endtask : wrap_up
