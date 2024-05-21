interface ac_if(input logic clk, input logic rst);
    logic [7:0] in;
    logic [15:0] sum;

    modport test (
        input sum, 
        output in, 
        input rst, 
        input clk
    );
endinterface : ac_if
