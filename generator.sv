class transaction;
    rand bit [7:0] in;
    bit [15:0] sum;
endclass

class generator;
    transaction tr;
    mailbox mbx, rtn;

    extern function new(mailbox mbx, mailbox rtn);
    extern virtual task run();
    extern virtual task wrap_up();
endclass : generator

function generator::new(mailbox mbx, mailbox rtn);
    this.mbx = mbx;
    this.rtn = rtn;
endfunction : new

task generator::run();
    tr = new();
    for (int i = 0; i < 100; i++) begin // Limiting to 100 transactions
        tr.randomize();              // Randomize the transaction
        mbx.put(tr);                 // Send the transaction to the driver
        $display("Generated transaction %0d with input: %0d", i, tr.in); // Debug statement
        rtn.get(tr);                 // Wait for acknowledgment from the driver
    end
endtask : run

task generator::wrap_up();
    $display("Generator wrap up.");
endtask : wrap_up
