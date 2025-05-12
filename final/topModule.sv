`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 04:29:32 PM
// Design Name: 
// Module Name: topModule
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



module topModule(input clk, input rst, input SSD_clk, output [3:0] Anode,output [6:0] LED_out );

wire [15:0] i_data[0:3];
wire [15:0] weights[0:3];

assign i_data[0] = 16'd1;
assign i_data[1] = 16'd2;
assign i_data[2] = 16'd3;
assign i_data[3] = 16'd4;

assign weights[0] = 16'd12;
assign weights[1] = 16'd6;
assign weights[2] = 16'd4;
assign weights[3] = 16'd3;

wire [15:0] o_result_pipelined;

cascaded_summation_pipelined DUT(.clk(clk),.rst(rst), .i_data(i_data),.weights(weights),.outputRes(o_result_pipelined));
Four_Digit_Seven_Segment_Driver_Opimized driver(SSD_clk, o_result_pipelined, Anode, LED_out);
endmodule
