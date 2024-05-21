`timescale 1ns/1ps

module accumulator (
    output reg [15:0] sum,  // accumulated out
    input [7:0] in,         // input
    input rst, clk          // reset and clock inputs
);
    wire carry;
    wire [15:0] sum_in; 
    assign {carry, sum_in} = sum + in;

    always @(posedge clk) begin
        if (rst) begin
            sum <= 0;
            $display("Resetting sum to 0 at time %0t", $time);
        end else begin
            sum <= (carry) ? 16'hFFFF : sum_in;
            $display("Sum updated to %0h with input %0h at time %0t", sum, in, $time);
        end
    end
endmodule
