`timescale 1ns / 1ps

module Ripple_Carry_Adder#(n=8) (
input [n-1 : 0] A,
input [n-1 : 0] B,
output [n : 0] Sum 
    );
    genvar i;
    wire [n : 0] Cin;
    assign Cin[0] = 0;
    
    
    generate
		for (i = 0; i < n; i = i + 1) begin
          Full_Adder FA(A[i], B[i], Cin[i], Sum[i], Cin[i + 1]);
		end
	endgenerate
	assign Sum[n] = Cin[n];
endmodule
