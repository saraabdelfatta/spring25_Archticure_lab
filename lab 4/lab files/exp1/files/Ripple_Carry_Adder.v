`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2025 10:04:35 AM
// Design Name: 
// Module Name: Ripple_Carry_Adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Ripple_Carry_Adder#(n = 32)(
    input [n-1:0] a,
    input [n-1:0] b,
    output cin,
    output [n:0] sum
    );
    genvar i;
    wire [n-1:0] internal_carry;
    assign internal_carry[0] = cin;
    
    generate
    for( i = 0; i < n; i = i + 1) begin
        Full_Adder FA(a[i], b[i], internal_carry[i],sum[i],internal_carry[i+1]);
    end
    endgenerate
    assign sum[n] = internal_carry[n];
endmodule
