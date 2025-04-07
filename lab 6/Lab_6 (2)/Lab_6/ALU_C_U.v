`timescale 1ns / 1ps



module ALU_C_U(input [14:12] inst1,input inst2, input [1:0] ALUOp, output reg [3:0] ALU_selection

    );
    
    always@(*)
    begin
    
    if(ALUOp==2'b00)
    ALU_selection=4'b0010;    //ADD
    
    else if(ALUOp==2'b01)
    ALU_selection=4'b0110;  //SUB
    
    else if(ALUOp==2'b10 & inst1[14:12] ==3'b000 & inst2==1'b0)
    ALU_selection=4'b0010;  //ADD
    
    else if(ALUOp==2'b10 & inst1[14:12] ==3'b000 & inst2==1'b1)
    ALU_selection=4'b0110;  //SUB
    
    else if(ALUOp==2'b10 & inst1[14:12] ==3'b111 & inst2==1'b0)
    ALU_selection=4'b0000;  //AND 
    
    else if(ALUOp==2'b10 & inst1[14:12] ==3'b110 & inst2==1'b0)
    ALU_selection=4'b0001;  //OR 
    
    end
    
    
endmodule
