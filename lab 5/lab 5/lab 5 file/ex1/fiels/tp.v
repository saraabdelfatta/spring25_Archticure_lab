`timescale 1ns / 1ps



module tp();

reg [5:0] addr;
wire [31:0] data_out;

InstMem meo(.addr(addr), .data_out(data_out));

  initial begin
        // Monitor the output
        $monitor("Time = %0t, Address = %d, Instruction = %h", $time, addr, data_out);

        // Test case 1: Read instruction at address 0
        addr = 6'd0; #10;
        
        // Test case 2: Read instruction at address 1
        addr = 6'd1; #10;
        
        // Test case 3: Read instruction at address 2
        addr = 6'd2; #10;
        
        // Test case 4: Read instruction at address 3
        addr = 6'd3; #10;
        
        // Test case 5: Read instruction at address 4
        addr = 6'd4; #10;

        // Additional test cases can be added here

        $finish; // End simulation
    end







endmodule
