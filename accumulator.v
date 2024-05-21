module accumulator (
    output reg [15:0] sum,    // accumulated output
    input [7:0] in,           // input
    input rst, clk            // reset and clock inputs
);

always @(posedge clk or posedge rst)
begin
    if (rst)
        sum <= 16'b0;
    else
        sum <= sum + in;
end

endmodule
