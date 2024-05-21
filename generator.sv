class transaction;
	rand bit [7:0] in;
	bit [15:0] sum;

endclass

class generator;
	transaction tr;
	mailbox mbx, rtn;
	extern function new(mailbox mbx, rtn);
	extern virtual task run();
	extern virtual task wrap_up();
endclass : generator

function generator::new(mailbox mbx, rtn);
	this.mbx=mbx;
	this.rtn=rtn;
endfunction : new

task generator::run();
  tr = new();
  forever begin
    tr.randomize();               // Randomize the transaction
    mbx.put(tr);                  // Send the transaction to the driver
    $display("Generated transaction with input: %0d", tr.in); // Debug statement
    rtn.get(tr);                  // Wait for acknowledgment from the driver
  end
endtask : run


task generator::wrap_up();
	//empty for now
endtask : wrap_up





	
