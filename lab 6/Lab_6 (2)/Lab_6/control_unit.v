`timescale 1ns / 1ps


module control_unit(input [6:2] inst, output reg Branch, MemRead, 
MemtoReg,MemWrite,ALUSrc,RegWrite,output reg[1:0] ALUOp );

always@(*)

begin
if(inst[6:2]==5'b01100)
begin
Branch=1'b0;
MemRead=1'b0;
MemtoReg=1'b0;
ALUOp=2'b10;
MemWrite=1'b0;
ALUSrc=1'b0;
RegWrite=1'b1;
end 


else if(inst[6:2]==5'b00000)

begin
Branch=1'b0;
MemRead=1'b1;
MemtoReg=1'b1;
ALUOp=2'b00;
MemWrite=1'b0;
ALUSrc=1'b1;
RegWrite=1'b1;
end

else if(inst[6:2]==5'b01000)
begin
Branch=1'b0;
MemRead=1'b0;
MemtoReg=1'b0;
ALUOp=2'b00;
MemWrite=1'b1;
ALUSrc=1'b1;
RegWrite=1'b0;
end

else if(inst[6:2]==5'b11000)
begin
Branch=1'b1;
MemRead=1'b0;
MemtoReg=1'b0;
ALUOp=2'b01;
MemWrite=1'b0;
ALUSrc=1'b0;
RegWrite=1'b0;
end

end
endmodule
