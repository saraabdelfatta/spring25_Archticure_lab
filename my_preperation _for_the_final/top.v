module top(input clk, input sdd, input rest, output reg [3:0] Anode,
           output reg [6:0] LED_out);
  wire [12:0] data[0:3];
  wire [12:0] whight[0:3];

assign data[0] = 16'd1; 
assign data[1] = 16'd2;
assign data[2] = 16'd3;
assign data[3] = 16'd4;

assign whight[0] = 16'd12;
assign whight[1] = 16'd6;
assign whight[2] = 16'd4;
assign whight[3] = 16'd3;

  wire[12:0] num; 

  cascaded_summation_pipelined  ddt(.clk(clk), .rest(rest), .data(data), .out(num));
  Four_Digit_Seven_Segment_Driver_Opimized driver(SSD_clk, o_result_pipelined, Anode, LED_out);
endmodule
