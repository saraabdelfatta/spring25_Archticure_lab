`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2025 12:24:28 PM
// Design Name: 
// Module Name: tb
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


module tb(

    );
    
    localparam clk_period = 10;
    localparam n = 8;
    reg clk;
    reg rst;
    reg load;
    reg [n-1:0] D;
    wire [n-1:0] Q;
    
    initial begin
    clk = 1'b0;
    forever #(clk_period/2)clk =~ clk;
    end
    
    N_bit_reg #(.n(n)) nbit(clk, rst, load, D, Q);
    
    initial begin
    rst = 1'b1;
    load = 1'b0;
    
    #clk_period
    
    rst = 1'b0;
    load = 1'b1;
    
    D = 15;
    
    #clk_period
    
    if (D == Q)
    $display("time = %t, successful, D = %d, Q = %d", $time, D, Q);
    else
    $display("time = %t, failed, D = %d, Q = %d", $time, D, Q);
    
    rst = 1'b1;
    load = 1'b0;
    D = 25;
    
    #clk_period
    
    rst = 1'b0;
    #clk_period;
    
    load = 1'b1;
    #clk_period
    
    if (D == Q)
    $display("time = %t, successful, D = %d, Q = %d", $time, D, Q);
    else
    $display("time = %t, failed, D = %d, Q = %d", $time, D, Q);
    
    #50
    $finish;    
    end 

    
endmodule
