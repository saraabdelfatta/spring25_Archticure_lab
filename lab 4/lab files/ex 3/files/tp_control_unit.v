`timescale 1ns / 1ps



module tp_control_unit(
    );
    
reg [6:2]inst;
wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
wire [1:0] ALUOp;

control_unit cu(inst,Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp);


initial begin

inst=5'b01100;   //R-format
#10
inst=5'b00000;   //LW
#10
inst=5'b01000;   //SW
#10
inst=5'b11000;   //BEQ


end



endmodule
