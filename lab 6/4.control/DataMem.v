`timescale 1ns / 1ps

//a simple data memory module named DataMem
//inputs::
//clk: Clock signal, used to synchronize the memory operations.
//MemRead: Control signal to enable reading from memory.
//MemWrite: Control signal to enable writing to memory.
//addr: A 6-bit address input to specify the memory location to read from or write to.
//data_in: A 32-bit data input to be written to the memory when MemWrite is enabled.

//outputs::
//data_out: A 32-bit data output that provides the data read from the memory when MemRead is enabled.
module DataMem (input clk, input MemRead, input MemWrite,
input [5:0] addr, input [31:0] data_in, output [31:0] data_out);

//Memory Array Declaration
//This line declares a memory array mem with 64 locations, each capable of storing a 32-bit value. 
//The array is indexed from 0 to 63, which corresponds to the 6-bit address input (addr).
reg [31:0] mem [0:63];


//synchronous Write Operation
//This block describes the synchronous write operation. 
//It is triggered on the rising edge of the clock (posedge clk).
always @(posedge clk) begin
    //If MemWrite is high (enabled), the data present on data_in is written to the memory location specified by addr.
    if (MemWrite) begin
        //The use of non-blocking assignment (<=) ensures that the write operation occurs in 
        //a synchronized manner with the clock.
        mem[addr] <= data_in;
    end
end

//asynchronous  Read Operation
//This line describes the asynchronous read operation.
//If MemRead is high (enabled), the data from the memory location specified by addr is assigned to data_out.
//If MemRead is low (disabled), data_out is assigned the value 0.
//The read operation is asynchronous because it does not depend on the clock signal; 
//it happens immediately when MemRead or addr changes.
assign data_out = MemRead ? mem[addr]:0;

    
endmodule
