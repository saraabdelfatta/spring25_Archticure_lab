`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2025 12:09:57 PM
// Design Name: 
// Module Name: N-bit_reg
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


module N_bit_reg#(parameter n = 8)(input clk, input rst, input load, input [n-1 : 0] D, output [n-1 : 0] Q 
    );
    wire [n-1:0] m_out;
    genvar i;
    
    generate 
    for (i = 0; i < n; i = i + 1) begin
    MUX_2x1 mux(D[i], Q[i], load, m_out[i]);
    DFlipFlop DFF(clk,rst,m_out[i], Q[i]);
    end
    endgenerate
endmodule
