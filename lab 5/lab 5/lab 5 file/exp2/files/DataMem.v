`timescale 1ns / 1ps


module DataMem (input clk, input MemRead, input MemWrite,
input [5:0] addr, input [31:0] data_in, output [31:0] data_out);

reg [31:0] mem [0:63];


//synchronous
always @(posedge clk) begin
    if (MemWrite) begin
        mem[addr] <= data_in;
    end
end

//asynchronous
assign data_out = MemRead ? mem[addr]:0;

    
endmodule
