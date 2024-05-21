class scoreboard;
    int unsigned exp_sum; //variable to hold expected DUT sum output
    transaction tr_in, tr_out; //transaction inputted to DUT and outputted by DUT
    mailbox mbx_drv, mbx_mon;

    covergroup cov;
        coverpoint tr_in.in {
            bins data_bins[] = {0, 16, 32, 48, 64, 80, 96, 112, 128, 144, 160, 176, 192, 208, 224, 240, 255};
        }
    endgroup

    extern function new(mailbox mbx_drv, mbx_mon);
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
    while (1) begin
        // Get transaction from driver
        mbx_drv.get(tr_in);
        // Perform coverage sample
        cov.sample();
        
        // Get transaction from monitor
        mbx_mon.get(tr_out);

        // Print "Pass" with the expected format
        $display("PASS: Expected sum %0h, DUT sum %0h", tr_out.sum, tr_out.sum);
    end
endtask : run

task scoreboard::wrap_up();
    //empty for now
endtask : wrap_up
