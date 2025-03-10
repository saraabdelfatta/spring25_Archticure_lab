`timescale 1ns / 1ps



module Full_Adder(
input A,
input B,
input Cin,
output Sum,
output Cout
    );
    
    assign {Cout, Sum} = A + B + Cin;
    
endmodule
