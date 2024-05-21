class scoreboard;
    mailbox mbx_drv, mbx_mon;
    transaction tr_in, tr_out;
    bit [15:0] exp_sum;

    function new(mailbox mbx_drv, mailbox mbx_mon);
        this.mbx_drv = mbx_drv;
        this.mbx_mon = mbx_mon;
        this.exp_sum = 0;
        tr_in = new();
        tr_out = new();
    endfunction

    task run();
        while (1) begin
            mbx_drv.get(tr_in);
            exp_sum = tr_in.sum + tr_in.in;
            if (exp_sum > 16'hFFFF) exp_sum = 16'hFFFF;
            mbx_mon.get(tr_out);
            if (tr_out.sum == exp_sum)
                $display("PASS: Expected sum %0h, DUT sum %0h", exp_sum, tr_out.sum);
            else
                $display("FAIL: Expected sum %0h, DUT sum %0h", exp_sum, tr_out.sum);
        end
    endtask

    task wrap_up();
        // empty for now
    endtask
endclass
