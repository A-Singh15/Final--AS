/*module accumulator (
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
        if (rst)
            sum <= 0;
        else 
            sum <= (carry) ? 16'hFFFF : sum_in;
    end
endmodule
*/
`timescale 1ns/1ps

module accumulator (
    output reg [15:0] sum,    // accumulated output
    input [7:0] in,           // input
    input rst, clk            // reset and clock inputs
);

wire carry;
wire [15:0] sum_in; 
assign {carry, sum_in} = sum + in;

always @(posedge clk or posedge rst) begin
    if (rst)
        sum <= 16'b0;  // Reset sum to 0
    else 
        sum <= (carry) ? 16'hFFFF : sum_in;  // Handle carry
end

endmodule
