`timescale 1ns / 1ps

//n is the parameter that define the divided ratio
module clockDivider #(parameter n=5000000)(
    input clk,  //clk
    input rst, //rest
    input en, //enable
    output reg out_clk  //(divided clock, declared as a register)
    );

    //Calculates the minimum number of bits needed to count up to n-1 using the system function 
    //$clog2 (ceiling of log base 2).
parameter Width=$clog2(n);

    //Declares a counter register with width calculated above to count clock cycles.
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
