`timescale 1ns / 1ps



module cascaded_summation_pipelined #(parameter WIDTH = 16)(
    input clk,rst,
    input [WIDTH-1:0] i_data [0:3],   // Four input data values
    input [WIDTH-1:0] weights [0:3], // Four weights
    output [WIDTH-1:0] outputRes  // Weighted sum output
);

    //stage 1
    wire [WIDTH-1:0] multiplyResult [0:3];
    wire [WIDTH-1:0] multiplyResult_S2 [0:3];
     genvar i;
     
    generate 
        for(i=0; i<4; i=i+1)begin
            assign multiplyResult[i] = i_data[i]*weights[i];
        end
    endgenerate 
    
    register #(WIDTH+WIDTH+WIDTH+WIDTH) reg1(clk, 1'b1, rst, {multiplyResult[3],multiplyResult[2],multiplyResult[1], multiplyResult[0]}, 
    {multiplyResult_S2[3],multiplyResult_S2[2],multiplyResult_S2[1], multiplyResult_S2[0]});
    
    // Stage 2
    wire [WIDTH-1:0] adderResult1;
    wire [WIDTH-1:0] adderResult2;
    wire [WIDTH-1:0] adderResult1_S3;
    wire [WIDTH-1:0] adderResult2_S3;
    
    assign adderResult1 = multiplyResult_S2[0] + multiplyResult_S2[1];
    assign adderResult2 = multiplyResult_S2[2] + multiplyResult_S2[3];
    
    register #(WIDTH+WIDTH) reg2(clk, 1'b1, rst, {adderResult1,adderResult2}, {adderResult1_S3, adderResult2_S3});
    
    // Stage 3
    assign outputRes = adderResult1_S3 + adderResult2_S3;

endmodule

