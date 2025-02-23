`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2025 12:03:27 PM
// Design Name: 
// Module Name: MUX_2x1
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


module MUX_2x1(input a, input b, input load, output out

    );
    
    assign out = (load == 1'b1) ? a : b;
    
endmodule
