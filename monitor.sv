class monitor;
    virtual ac_if.test acif;
    mailbox mbx_scb;
    transaction tr;

    extern function new(mailbox mbx_scb, input virtual ac_if.test acif);
    extern virtual task run();
    extern virtual task wrap_up();
endclass : monitor

function monitor::new(mailbox mbx_scb, input virtual ac_if.test acif);
    this.mbx_scb = mbx_scb;
    this.acif = acif;
    tr = new();
endfunction : new

task monitor::run();
    // Introduce a 1-clock cycle delay
    @(posedge acif.clk);
    while (1) begin
        @(posedge acif.clk);
        tr.sum = acif.sum;
        mbx_scb.put(tr);
    end
endtask : run

task monitor::wrap_up();
    // empty for now
endtask : wrap_up
endclass
