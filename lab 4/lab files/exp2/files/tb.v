`timescale 1ns / 1ps

module tb();
localparam clk_period = 100;
localparam n = 32;
reg clk;
reg rst;
reg reg_write;
reg [4:0] rr1;
reg [4:0] rr2;
reg [4:0] wr;
reg [31:0] wd;

wire [31:0] rd1;
wire [31:0] rd2;

regFile test(.clk(clk),
             .rst(rst),
             .reg_write(reg_write),
             .rr1(rr1),
             .rr2(rr2),
             .wr(wr),
             .wd(wd),
             .rd1(rd1),
             .rd2(rd2)
             );

initial  begin
clk = 1'b0; 
forever #(clk_period/2) clk =~ clk; 
end


initial begin
rst = 1;
reg_write = 0;
rr1 = 0;
rr2 = 0;
wr = 0;
wd = 0;
#(clk_period);

rst = 0;
reg_write = 0;
rr1 = 0;
rr2 = 0;
wr = 0;
wd = 0;
#(clk_period);

rst = 0;
reg_write = 1;
rr1 = 2;
rr2 = 1;
wr = 2;
wd = 20;
#(clk_period);

rst = 0;
reg_write = 1;
rr1 = 2;
rr2 = 1;
wr = 1;
wd = 10;
#(clk_period);


end
endmodule