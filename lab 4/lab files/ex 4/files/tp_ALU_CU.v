`timescale 1ns / 1ps



module tp_ALU_CU(

    );
    
reg [14:12] inst1;
reg inst2;
reg [1:0] ALUOp1;
wire [3:0] ALU_selection;
    
ALU_C_U  ALUcu(inst1,inst2, ALUOp1, ALU_selection);
    
 initial begin
 
 ALUOp1=2'b00;
 inst1[14:12] =3'bX;
 inst2=1'bX;
 
 #100 
 
  ALUOp1=2'b01;
 inst1[14:12] =3'bX;
 inst2=1'bX;
 
 #100
  ALUOp1=2'b10;
 inst1[14:12] =3'b000;
 inst2=1'b0;
 
 #100
  ALUOp1=2'b10;
 inst1[14:12] =3'b000;
 inst2=1'b1;
 
 #100
  ALUOp1=2'b10;
 inst1[14:12] =3'b111;
 inst2=1'b0;
 
 #100
  ALUOp1=2'b10;
 inst1[14:12] =3'b110;
 inst2=1'b0;
 
 end
    
    
endmodule
