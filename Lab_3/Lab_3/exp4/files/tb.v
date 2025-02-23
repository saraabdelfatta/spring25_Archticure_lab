`timescale 1ns / 1ps

module tb();

reg [31:0] inst; 
wire [31:0] gen_out;

immGen I(inst,gen_out); 

initial begin

inst = 32'h1a3f8b7d; //beq
#100
if(gen_out == 32'h000000db)
$display("time = %t, success", $time);
else
$display("time = %t, fail", $time);
#100

inst = 32'h1a3f8b3d; //sw
#100 
if(gen_out == 32'h000001b6)
$display("time = %t, success", $time);
else
$display("time = %t, fail", $time);
#100

inst = 32'h1a3f8b0d; //lw
#100 
if(gen_out == 32'h000001a3)
$display("time = %t, success", $time);
else
$display("time = %t, fail", $time);
#100

$finish;
end 
endmodule
