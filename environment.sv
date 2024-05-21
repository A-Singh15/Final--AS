class environment;
	generator gen;
	driver drv;
	monitor mon;
	scoreboard scb;
	mailbox gen2drv, drv2gen, mon2scb, drv2scb;

	virtual ac_if.test acif;
	
	extern function new(input virtual ac_if.test acif);
	extern virtual function void build();
	extern virtual task run();
	extern virtual task wrap_up();
endclass : environment

function environment::new(input virtual ac_if.test acif);
	this.acif = acif;
endfunction : new

function void environment::build();
	gen2drv = new();
	drv2gen= new();
	mon2scb = new();
	drv2scb = new();
	gen = new(gen2drv, drv2gen);
	drv = new(gen2drv, drv2gen, drv2scb, acif);
	scb = new(drv2scb, mon2scb);
	mon = new(mon2scb, acif);
endfunction : build


task environment::run();
	fork
		gen.run();
		drv.run();
		mon.run();
		scb.run();
	join_none
endtask : run

task environment::wrap_up();
	fork
		gen.wrap_up();
		drv.wrap_up();
		mon.wrap_up();
		scb.wrap_up();
	join
endtask : wrap_up


