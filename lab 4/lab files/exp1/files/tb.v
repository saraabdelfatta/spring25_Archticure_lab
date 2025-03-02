`timescale 1ns / 1ps



module tb();
localparam n =32;
reg [n-1:0] a;
reg [n-1:0]b;
reg [3:0]sel;
wire zero; 
wire [n-1:0]ALU_out;

ALU#(.n(n)) test(a,b,sel,zero,ALU_out);

initial begin

a = 60;
b = 40;
sel = 4'b0010;   
#100

a = 60;
b = 40;
sel = 4'b0110;   
#100

a = 5'b11001;
b = 5'b11101;
sel = 4'b0000;   
#100

a = 5'b11001;
b = 5'b11101;
sel = 4'b0001; 

#100

a = 5'b11001;
b = 5'b11101;
sel = 4'b1111; 
  
end

endmodule
