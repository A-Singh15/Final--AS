class transaction;
    rand bit [7:0] in;
    bit [15:0] sum;
endclass

class generator;
    transaction tr;
    mailbox mbx, rtn;
    bit [15:0] cumulative_sum;

    extern function new(mailbox mbx, rtn);
    extern virtual task run();
    extern virtual task wrap_up();
endclass : generator

function generator::new(mailbox mbx, rtn);
    this.mbx = mbx;
    this.rtn = rtn;
    this.cumulative_sum = 0;
endfunction : new

task generator::run();
    while (1) begin
        tr = new();
        assert(tr.randomize());
        tr.sum = cumulative_sum;
        cumulative_sum = (cumulative_sum + tr.in > 16'hFFFF) ? 16'hFFFF : cumulative_sum + tr.in;
        mbx.put(tr);
        // Wait for acknowledgment from driver
        rtn.get(tr);
    end
endtask : run

task generator::wrap_up();
    //empty for now
endtask : wrap_up

