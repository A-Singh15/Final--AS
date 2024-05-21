program automatic test(ac_if.test acif);

environment env;
initial begin
	$vcdpluson;
	env = new(acif);
	env.build();
	env.run();
	env.wrap_up();
end

endprogram

