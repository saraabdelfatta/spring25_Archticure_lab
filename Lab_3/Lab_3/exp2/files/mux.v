`timescale 1ns / 1ps



module mux(input a, input b, input sel, output out

    );
    
    assign out = (sel == 1'b0)? a:b;
endmodule
