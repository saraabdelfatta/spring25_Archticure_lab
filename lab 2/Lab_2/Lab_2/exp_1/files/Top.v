`timescale 1ns / 1ps

module Top(
input clk,
input [7 : 0] A,
input [7 : 0] B,
output [6 : 0] LED_out,
output [3 : 0] Anode
    );
    wire [8 : 0] Sum;
    wire[12 : 0] num;
    
    Ripple_Carry_Adder  RCA(A, B, Sum);
    assign num = {4'd0, Sum};
    
    Seven_Segment SS(clk, num, Anode, LED_out);
    

endmodule
