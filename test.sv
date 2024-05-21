program automatic test(ac_if.test acif);
    environment env;
    int num_transactions = 100; // Set the number of transactions

    initial begin
        $vcdpluson;
        env = new(acif, num_transactions);
        env.build();
        env.run();
        env.wrap_up();
    end
endprogram
