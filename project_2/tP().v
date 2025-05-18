module testbench;

    reg clk, reset;
    
    // Instantiate the simulator
    TomasuloSimulator sim(clk, reset);
    
    // Clock generation
    always #5 clk = ~clk;
    
    // Test program
    initial begin
        // Initialize
        clk = 0;
        reset = 1;
        
        // Load test program after reset
        #10 reset = 0;
        
        // Simple test program:
        // 1. LOAD R1, 0(R2)
        // 2. ADD R3, R1, R4
        // 3. BEQ R1, R2, 5
        begin
            reg [31:0] test_program [0:2];
            test_program[0] = {5'b00000, 3'b001, 3'b010, 3'b000, 16'b0};  // LOAD R1,0(R2)
            test_program[1] = {5'b00010, 3'b011, 3'b001, 3'b100, 16'b0};  // ADD R3,R1,R4
            test_program[2] = {5'b00100, 3'b000, 3'b001, 3'b010, 16'b5};  // BEQ R1,R2,5
            
            sim.load_program(test_program, 3);
            
            // Initialize registers and memory
            sim.registers[2] = 16'h1000;  // R2 = memory base
            sim.registers[4] = 16'h0005;  // R4 = 5
            sim.memory[16'h1000] = 16'h1234;  // MEM[R2] = 0x1234
        end
        
        // Run for 50 cycles
        #500 $finish;
    end
    
endmodule
