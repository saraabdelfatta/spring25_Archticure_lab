`timescale 1ns / 1ps


module ALU#(n = 32)(
    input [n-1:0] a,
    input [n-1:0] b,
    input [3:0] sel,
    output reg zeroFlag,
    output reg [n:0] ALU_out
    );
    wire [n-1:0] sum;
    wire [n-1:0] b_twos;
    assign b_twos = (sel[3:0] == 4'b0010) ? b : ~b;
    Ripple_Carry_Adder #(.n(n)) RCA (.a(a), .b(b_twos), .cin(sel[2]), .sum(sum));
    always@(*)
    begin
        case(sel)
            4'b0010: ALU_out = sum;
            4'b0110: ALU_out = sum;
            4'b0000: ALU_out = a & b;
            4'b0001: ALU_out = a | b;
            default: ALU_out = 0;
        endcase
        if(ALU_out != 0)
            zeroFlag = 0;
        else
            zeroFlag = 1;
    end
endmodule
