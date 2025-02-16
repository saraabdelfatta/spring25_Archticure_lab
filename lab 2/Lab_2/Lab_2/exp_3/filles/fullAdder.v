`timescale 1ns / 1ps

module fullAdder(
input A,
input B,
input Cin,
output Sum,
output Cout
    );
    
    assign {Cout, Sum} = A + B + Cin;
    
endmodule
