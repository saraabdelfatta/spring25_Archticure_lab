`timescale 1ns / 1ps

module immGen#(n=32)(input [n-1:0] inst, output reg [n-1:0] gen_out);

always @(*) 
begin

if (inst[6:5] == 2'b11) //BEQ
    begin
    gen_out = {{20{inst[31]}},inst[31],inst[7],inst[30:25],inst[11:8]};
    end
else if (inst[6:5] == 2'b00) //LW
    begin
    gen_out = {{20{inst[31]}},inst[31:20]};
    end
else if (inst[6:5] == 2'b01) //SW
    begin
    gen_out = {{20{inst[31]}},inst[31:25],inst[11:7]};
    end
end
endmodule
