module top;
    // Declare clock and reset signals
    logic clk;
    logic rst;
    // Instantiate the interface
    ac_if acif(.clk(clk), .rst(rst));  // Connect clk and rst signals directly during instantiation

    // Instantiate the accumulator
    accumulator acc (
        .clk(acif.clk),
        .rst(acif.rst),
        .in(acif.in),
        .sum(acif.sum)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset generation
    initial begin
        rst = 1;
        #20;
        rst = 0;
    end

    // Instantiate the test program
    test t(acif);  // No dot notation here, just pass the interface

endmodule : top
