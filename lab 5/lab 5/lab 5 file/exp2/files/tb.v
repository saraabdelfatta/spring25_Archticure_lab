`timescale 1ns / 1ps

module tb();
reg clk,MemRead,MemWrite;
reg [5:0] addr;
reg [31:0] data_in;
wire [31:0] data_out;
parameter PERIOD=10;

DataMem DM(clk, MemRead, MemWrite, addr, data_in, data_out);

always begin
clk = 1'b0;
#(PERIOD/2) clk = 1'b1;
#(PERIOD/2);
end


initial begin

MemWrite=0;
MemRead=0;
addr=0;
data_in=0;
#10

MemWrite=1;
addr=0;
data_in=32'd39;
MemRead=1;
#10;

MemWrite=0;
addr=1;
data_in=32'd22;
#10;

MemRead=1;
addr=2;
data_in=32'd53;

end

endmodule
