`timescale 1ns / 1ps


module regFile(
    input clk,
    input rst,
    input reg_write,
    input [4:0] rr1,
    input [4:0] rr2,
    input [4:0] wr,
    input [31:0] wd,
    output [31:0] rd1,
    output [31:0] rd2
    );
    
    
    reg [31:0] regfile[31:0];
    
    always @(posedge clk or posedge rst) begin
        if (rst == 1) begin
            for (integer i = 0; i<32; i = i + 1) begin
                regfile[i] <= 0;
            end
        end
        else begin
            if (reg_write == 1'b1)
                regfile [wr] <= wd;
            end             
     end
     
     assign rd1 = regfile[rr1];
     assign rd2 = regfile[rr2];
     
endmodule
