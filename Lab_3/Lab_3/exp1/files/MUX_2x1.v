`timescale 1ns / 1ps



module MUX_2x1(input a, input b, input load, output out

    );
    
    assign out = (load == 1'b1) ? a : b;
    
endmodule
