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
        // Wait for reset to be deasserted
        wait(acif.rst == 0);
        @(acif.clk);
        if (acif.sum == 0)
            $display("Reset successful.");
        else
            $display("Reset failed.");

        while (1) begin
            mbx.get(tr);
            tr.sum = acif.sum;
            rtn.put(tr);
            mbx_scb.put(tr);
            acif.in <= tr.in;
            @(acif.clk);
        end
    endtask

    task wrap_up();
        wait (acif.sum == 16'hFFFF);
        @acif.clk;
        $display("***Sum output saturated to 16'hFFFF; Finishing simulation***");
        $finish;
    endtask
endclass
