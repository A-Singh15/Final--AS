class monitor;
	virtual ac_if.test acif;
	transaction tr;
	mailbox mbx;
	extern function new(mailbox mbx, input virtual ac_if.test acif);
	extern virtual task run();
	extern virtual task wrap_up();
endclass : monitor

function monitor::new(mailbox mbx, input virtual ac_if.test acif);
	this.mbx=mbx;
	this.acif = acif;
	tr=new();
endfunction : new


task monitor::run();
    // Wait for reset to be applied and removed
    wait (acif.cb.rst == 1);
    wait (acif.cb.rst == 0);

    // Monitor DUT output in each clock cycle
    forever begin
        @(posedge acif.cb.clk);
        tr.sum = acif.cb.sum;          // Read DUT sum output
        mbx.put(tr);                   // Send the transaction to the scoreboard
    end
endtask : run

	
task monitor::wrap_up();
	//empty for now
endtask : wrap_up




	
