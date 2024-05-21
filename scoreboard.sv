class scoreboard;
    int unsigned exp_sum;              // Variable to hold expected DUT sum output
    transaction tr_in, tr_out;         // Transactions inputted to and outputted by DUT
    mailbox mbx_drv, mbx_mon;

    // Functional coverage definition
    covergroup cov;
        coverpoint tr_in.in {
            bins auto_bins = auto [16]; // 16 equally sized bins for 8-bit input data
        }
    endgroup

    extern function new(mailbox mbx_drv, mailbox mbx_mon);
    extern virtual task run();
    extern virtual task wrap_up();
endclass : scoreboard

function scoreboard::new(mailbox mbx_drv, mailbox mbx_mon);
    this.mbx_drv = mbx_drv;
    this.mbx_mon = mbx_mon;
    this.exp_sum = 0;
    tr_in = new();
    tr_out = new();
    cov = new;
endfunction : new

task scoreboard::run();
    // Main operation loop
    forever begin
        mbx_drv.get(tr_in);            // Get a transaction from the driver
        cov.sample();                  // Perform coverage sample

        // Compute expected DUT sum output
        exp_sum = exp_sum + tr_in.in;
        if (exp_sum > 16'hFFFF) exp_sum = 16'hFFFF;

        mbx_mon.get(tr_out);           // Get a transaction from the monitor

        // Compare the obtained DUT sum output with the expected sum output
        if (tr_out.sum == exp_sum)
            $display("PASS: sum output is correct");
        else
            $display("FAIL: expected sum=%0h, obtained sum=%0h", exp_sum, tr_out.sum);
    end
endtask : run
