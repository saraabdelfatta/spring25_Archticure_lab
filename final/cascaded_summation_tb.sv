`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 03:19:28 PM
// Design Name: 
// Module Name: cascaded_summation_tb
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

module cascaded_summation_tb();
reg clk;
reg rst;
reg [15:0] i_data [0:3];   
reg [15:0] weights [0:3]; 
wire [15:0] o_result_pipelined; 

localparam period=10;
cascaded_summation_pipelined DUT(.clk(clk),.rst(rst), .i_data(i_data),.weights(weights),.outputRes(o_result_pipelined));


initial begin
clk=0;
forever #(period/2) clk=~clk;
end

initial begin
rst=1;

#period
rst=0;
i_data[0] = 16'd1;
i_data[1] = 16'd2;
i_data[2] = 16'd3;
i_data[3] = 16'd4;

weights[0] = 16'd12;
weights[1] = 16'd6;
weights[2] = 16'd4;
weights[3] = 16'd3;

#(period)


i_data[0] = 16'd2;
i_data[1] = 16'd2;
i_data[2] = 16'd2;
i_data[3] = 16'd2;

weights[0] = 16'd5;
weights[1] = 16'd5;
weights[2] = 16'd5;
weights[3] = 16'd5;

#(period)

if(o_result_pipelined  == 16'd48) begin
    $display("Test 1: Output is correct");
end
i_data[0] = 16'd1;
i_data[1] = 16'd1;
i_data[2] = 16'd1;
i_data[3] = 16'd1;

weights[0] = 16'd2;
weights[1] = 16'd5;
weights[2] = 16'd7;
weights[3] = 16'd9;

#(period)

if(o_result_pipelined  == 16'd40) begin
    $display("Test 2: Output is correct");
end
i_data[0] = 16'd0;
i_data[1] = 16'd0;
i_data[2] = 16'd5;
i_data[3] = 16'd3;

weights[0] = 16'd13;
weights[1] = 16'd5;
weights[2] = 16'd5;
weights[3] = 16'd4;

#(period)
if(o_result_pipelined  == 16'd23) begin
    $display("Test 3: Output is correct");
end
#(period)
if(o_result_pipelined  == 16'd37) begin
    $display("Test 4: Output is correct");
end
$finish;


end

endmodule