class scoreboard;
    mailbox mbx_drv, mbx_mon;
    transaction tr_in, tr_out;
    bit [15:0] exp_sum;

    // Constructor
    function new(mailbox mbx_drv, mailbox mbx_mon);
        this.mbx_drv = mbx_drv;
        this.mbx_mon = mbx_mon;
        this.exp_sum = 0;
        tr_in = new();
        tr_out = new();
    endfunction : new

    // Run the scoreboard
    virtual task run();
        while (1) begin
            // Get transaction from driver
            mbx_drv.get(tr_in);
            // Compute expected sum
            exp_sum = tr_in.sum + tr_in.in;
            if (exp_sum > 16'hFFFF) exp_sum = 16'hFFFF;
            // Get transaction from monitor
            mbx_mon.get(tr_out);
            // Compare the outputs
            if (tr_out.sum == exp_sum)
                $display("PASS: Expected sum %0h, DUT sum %0h", exp_sum, tr_out.sum);
            else
                $display("FAIL: Expected sum %0h, DUT sum %0h", exp_sum, tr_out.sum);
        end
    endtask : run

    // Wrap-up the scoreboard
    virtual task wrap_up();
        //empty for now
    endtask : wrap_up
endclass : scoreboard
