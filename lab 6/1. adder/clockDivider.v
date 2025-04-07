`timescale 1ns / 1ps

module clockDivider #(parameter n=5000000)(
    input clk,
    input rst,
    input en,
    output reg out_clk
    );
parameter Width=$clog2(n);
reg [Width-1:0] count;

always @(posedge clk, posedge rst) begin
    if(rst)
        count<=32'b0;
    else if(count==n-1)
        count<=32'b0;
    else if(en)
        count<=count+1;
end

always @(posedge clk, posedge rst)begin
    if(rst) out_clk<=0;
    else if(count==n-1) out_clk<=~out_clk;
end
endmodule