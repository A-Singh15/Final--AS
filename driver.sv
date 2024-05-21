class driver;
	
	virtual ac_if.test acif;
	transaction tr;
	mailbox mbx, rtn, mbx_scb;
	extern function new(mailbox mbx, rtn, mbx_scb, input virtual ac_if.test acif);
	extern virtual task run();
	extern virtual task wrap_up();
endclass : driver

function driver::new(mailbox mbx, rtn, mbx_scb, input virtual ac_if.test acif);
	this.mbx=mbx;
	this.rtn=rtn;
	this.mbx_scb=mbx_scb;
	this.acif = acif;
	tr=new();
endfunction : new


task driver::run();
	//write the run task here








endtask : run
	
task driver::wrap_up();
	wait (acif.cb.sum == 16'hFFFF);
	@acif.cb;
	$display("*********Sum output saturated to 16'hFFFF; Finishing simulation**********");
	$finish;
endtask : wrap_up




	
