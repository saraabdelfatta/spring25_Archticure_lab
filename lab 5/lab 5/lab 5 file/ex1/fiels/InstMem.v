`timescale 1ns / 1ps



module InstMem(

//address input: 6 bit word address
input [5:0] addr,

//data output: 32 bit instruction 
output [31:0] data_out
    );
    
    //64 word instruction memory
    reg [31:0] mem [0:63];
    
    // Initialize the instruction memory with some values
    initial begin
    
     mem[0]  = 32'h00000013;  // Example NOP instruction
        mem[1]  = 32'h00100093;  // ADDI x1, x0, 1
        mem[2]  = 32'h00200113;  // ADDI x2, x0, 2
        mem[3]  = 32'h003081B3;  // ADD x3, x1, x2
        mem[4]  = 32'hFFF00213;  // ADDI x4, x0, -1
        mem[5]  = 32'hFE000EE3;  // BEQ x0, x0, -4 (loop)

    
    end
    
    
    
   assign data_out = mem[addr];
    
endmodule
