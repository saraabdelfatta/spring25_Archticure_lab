`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2025 01:51:50 PM
// Design Name: 
// Module Name: nbit_shift_left
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


module nbit_shift_left#(parameter n = 8)(input [n-1:0] in, output [n-1:0] out
    );
    
    assign out = {in[n-2:0], 1'b0};
    
endmodule
