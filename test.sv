`timescale 1ns/1ps
program automatic test(ac_if.test acif);

environment env;
initial begin
    $vcdpluson;
    env = new(acif);
    env.build();
    
    // Apply reset
    acif.rst <= 1;
    #20;
    acif.rst <= 0;
    
    env.run();
    env.wrap_up();
end

endprogram
