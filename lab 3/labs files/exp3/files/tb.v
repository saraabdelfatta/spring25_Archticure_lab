`timescale 1ns / 1ps


module tb();
localparam n = 8;
reg [n-1:0]in;
wire [n-1:0]out;


nbit_shift_left#(.n(n)) inst(in,out);


initial begin
in = 29;
#100;

in = 5;

#100;
end


endmodule
