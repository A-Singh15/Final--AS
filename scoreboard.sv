class scoreboard;
	int unsigned exp_sum;
	transaction tr_in, tr_out;
	mailbox mbx_drv, mbx_mon;

	covergroup cov;
		//write the functional coverage definition here




	

	endgroup


	extern function new(mailbox mbx_drv, mbx_mon);
	extern virtual task run();
	extern virtual task wrap_up();
endclass : scoreboard

function scoreboard::new(mailbox mbx_drv, mbx_mon);
	this.mbx_drv=mbx_drv;
	this.mbx_mon=mbx_mon;
	this.exp_sum = 0;
	tr_in=new();
	tr_out = new();
	cov = new;
endfunction : new


task scoreboard::run();
	//write the run task here









endtask : run
	
task scoreboard::wrap_up();
	//empty for now
endtask : wrap_up



	
