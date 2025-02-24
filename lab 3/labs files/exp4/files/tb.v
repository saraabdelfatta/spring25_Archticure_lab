`timescale 1ns / 1ps

module tb();

reg [31:0] inst; 
wire [31:0] gen_out;

immGen I(inst,gen_out); 

initial begin

inst = 32'b10000001010101010000000001100011; //BEQ
#100
if(gen_out == 32'b11111111111111111111100000000000)
$display("time = %t, gen_out = %b success", $time, gen_out);
else
$display("time = %t, gen_out = %b fail", $time, gen_out);
#100


inst = 32'b00011001000000000001000000000011; //LW
#100 
if(gen_out == 32'b00000000000000000000000110010000)
$display("time = %t, gen_out = %b success", $time, gen_out);
else
$display("time = %t, gen_out = %b fail", $time, gen_out);
#100

inst = 32'b10000001010101010010000000100011; //SW
#100 
if(gen_out == 32'b11111111111111111111100000000000)
$display("time = %t, gen_out = %b success", $time, gen_out);
else
$display("time = %t, gen_out = %b fail", $time, gen_out);
#100


$finish;
end 
endmodule
