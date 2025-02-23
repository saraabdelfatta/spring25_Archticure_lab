`timescale 1ns / 1ps

module immGen(input [31:0] inst, output reg [31:0] gen_out);

always @(*) begin

if (inst[6:5] == 2'b11) //BEQ
gen_out = {{20{inst[31]}},inst[31],inst[7],inst[30:25],inst[11:8]};
else if (inst[6:5] == 2'b00) //Lw
gen_out = {{20{inst[31]}},inst[31:20]};
else if (inst[6:5] == 2'b01) //Sw
gen_out = {{20{inst[31]}},inst[31:25],inst[11:7]};
end
endmodule
