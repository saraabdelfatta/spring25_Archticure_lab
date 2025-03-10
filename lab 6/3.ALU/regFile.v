`timescale 1ns / 1ps


module regFile(
    input clk,        //Clock signal for synchronization.
    input rst,        //Reset signal to initialize the register file.
    input reg_write,  //Control signal to enable writing to the register file.
    input [4:0] rr1,  //5-bit addresses for reading two registers (read addresses).
    input [4:0] rr2,  //5-bit addresses for reading two registers (read addresses).
    input [4:0] wr,   //5-bit address for writing to a register (write address).
    input [31:0] wd,  //32-bit data to be written into the register file.
    output [31:0] rd1, //32-bit data read from the registers specified by rr1 and rr2.
    output [31:0] rd2  //32-bit data read from the registers specified by rr1 and rr2.
    );
    
    //This declares a register file with 32 registers, each 32 bits wide.
    //regfile[31:0] means there are 32 registers, indexed from 0 to 31.
    reg [31:0] regfile[31:0];

    //Always Block for Synchronous Operations
    //This block is triggered on the rising edge of the clock (posedge clk) 
    //the rising edge of the reset signal (posedge rst).
    always @(posedge clk or posedge rst) begin
        //Reset Condition (rst == 1):
        //When the reset signal is high, all 32 registers in the register file are initialized to 0 using a for loop.
        if (rst == 1) begin
            for (integer i = 0; i<32; i = i + 1) begin
                regfile[i] <= 0;
            end
        end
        else begin
            //Write Operation (reg_write == 1'b1):
            //If the reg_write signal is high, the data wd is written into the register specified by the write address wr.
            if (reg_write == 1'b1)
                regfile [wr] <= wd;
            end             
     end

    //hese assignments continuously read the values from the registers specified by rr1 and rr2 and 
    //assign them to rd1 and rd2, respectively.
    //Reading is asynchronous and happens independently of the clock.
     assign rd1 = regfile[rr1];
     assign rd2 = regfile[rr2];
     
endmodule
