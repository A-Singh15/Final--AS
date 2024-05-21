class driver;
    virtual ac_if.test acif;
    transaction tr;
    mailbox mbx, rtn, mbx_scb;

    extern function new(mailbox mbx, mailbox rtn, mailbox mbx_scb, input virtual ac_if.test acif);
    extern virtual task run();
    extern virtual task wrap_up();
endclass : driver

function driver::new(mailbox mbx, mailbox rtn, mailbox mbx_scb, input virtual ac_if.test acif);
    this.mbx = mbx;
    this.rtn = rtn;
    this.mbx_scb = mbx_scb;
    this.acif = acif;
    tr = new();
endfunction : new

task driver::run();
    // Apply reset at the beginning
    acif.cb.rst <= 1;
    repeat (2) @(posedge acif.clk);
    acif.cb.rst <= 0;
    repeat (2) @(posedge acif.clk);

    // Self-check reset
    if (acif.cb.sum == 0) 
        $display("Reset operation successful: sum is zero");
    else 
        $display("Reset operation failed: sum is not zero");

    // Main operation loop
    for (int i = 0; i < 100; i++) begin
        mbx.get(tr);                   // Get a transaction from the generator
        rtn.put(tr);                   // Acknowledge the transaction to the generator
        mbx_scb.put(tr);               // Send the transaction to the scoreboard
        acif.cb.in <= tr.in;           // Drive the DUT interface with the transaction
        $display("Driving input: %0d", tr.in);  // Debug statement
        @(posedge acif.clk);           // Wait for a clock cycle
    end
endtask : run

task driver::wrap_up();
    wait (acif.cb.sum == 16'hFFFF);
    @acif.cb;
    $display("***Sum output saturated to 16'hFFFF; Finishing simulation***");
    $finish;
endtask : wrap_up
