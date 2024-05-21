class monitor;
    virtual ac_if.test acif;
    mailbox mbx_scb;
    transaction tr;

    function new(mailbox mbx_scb, input virtual ac_if.test acif);
        this.mbx_scb = mbx_scb;
        this.acif = acif;
        tr = new();
    endfunction

    task run();
        while (1) begin
            @(posedge acif.clk);
            tr.sum = acif.sum;
            mbx_scb.put(tr);
        end
    endtask

    task wrap_up();
        // empty for now
    endtask
endclass
