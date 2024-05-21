interface ac_if (input bit clk);
    logic [7:0] in;
    logic rst;
    logic [15:0] sum;

    clocking cb @(posedge clk);
        default input #1 output #1;
        output in, rst;
        input sum;
    endclocking : cb

    modport dut (
        input rst, in,
        output sum
    );

    modport test (
        clocking cb,
        input clk,
        output rst,
        input sum // Added sum here to make it accessible in the test modport
    );

endinterface : ac_if
