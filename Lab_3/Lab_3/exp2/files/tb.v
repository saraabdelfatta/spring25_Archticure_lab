`timescale 1ns / 1ps

module tb();
localparam n = 8;
reg [n-1:0]a;
reg [n-1:0]b;
reg sel;
wire [n-1:0]out; 


initial begin

a= 20;
b= 15; 
sel= 0; 
#10
if(a == out )
$display("time = %t, success", $time);
else
$display("time = %t, fail", $time);
#100

a= 10;
b= 30; 
sel= 1; 
#10
if(b == out )
$display("time = %t, success", $time);
else
$display("time = %t, fail", $time);

end

nbit_mux#(.n(n)) inst(a,b,sel,out);



endmodule