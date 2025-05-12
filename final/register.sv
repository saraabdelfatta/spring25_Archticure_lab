`timescale 1ns / 1ps

//multibluxer 
module mux2x1(input a, b, sel, output c);
assign c = ((a & ~sel) | (b & sel));
endmodule

module DFlipFlop
(input clk, input rst, input D, output reg Q);
always @ (posedge clk or posedge rst)
if (rst) begin
Q <= 1'b0;
end else begin
Q <= D;
end
endmodule 


module register#(parameter n = 8)(input clk, input load, input rst, input [n-1:0] D, output [n-1:0] Q);
genvar i;
wire [n-1:0] d_temp;
generate 
for(i = 0; i<n; i = i+1)
begin 
mux2x1 mux(.a(Q[i]),.b(D[i]),.sel(load),.c(d_temp[i]));
DFlipFlop DFF(.clk(clk), .rst(rst), .D(d_temp[i]), .Q(Q[i])); 
end
endgenerate 
endmodule

