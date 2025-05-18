module TomasuloSimulator(
    input clk,
    input reset
);

    // Global parameters
   // parameter NUM_REGS = 8;
   // parameter NUM_RS = 8;  // Total reservation stations
    parameter MEM_SIZE = 65536;  // 16-bit address space
    
    // Register file
    reg [15:0] registers [0:7];
    reg [4:0] reg_status [0:7];  // Which RS is writing to each register
    
    // Memory
    reg [15:0] memory [0:65535];
    
    // Reservation stations
    typedef struct packed {
        bit busy;
        bit [4:0] opcode;  // Encoded operation type
        bit [2:0] dest;
        bit [15:0] vj, vk;
        bit [4:0] qj, qk;  // Source RS tags
        bit [15:0] address;
        bit [15:0] result;
        bit [7:0] cycles_left;
    } reservation_station;
    
    reservation_station rs [0:7];
    
    // Instruction queue
    reg [31:0] instruction_queue [0:15];  // Up to 16 instructions
    reg [3:0] iq_head, iq_tail;
    
    // Performance counters
    integer clock_cycles;
    integer instructions_completed;
    integer branches;
    integer mispredictions;
    
    // Instruction encoding (simplified)
    localparam OP_LOAD  = 0;
    localparam OP_STORE = 1;
    localparam OP_ADD   = 2;
    localparam OP_MUL   = 3;
    localparam OP_BEQ   = 4;
    
    // Execution units
    reg [15:0] add_result, mul_result;
    reg add_done, mul_done;
    integer add_counter, mul_counter;
    
    // Initialize system
    initial begin
        if (reset) begin
            clock_cycles = 0;
            instructions_completed = 0;
            branches = 0;
            mispredictions = 0;
            
            // Clear registers
            for (integer i = 0; i < 8; i = i + 1) begin
                registers[i] = 0;
                reg_status[i] = 0;
            end
            registers[0] = 0;  // R0 always zero
            
            // Clear reservation stations
            for (integer i = 0; i < 8; i = i + 1) begin
                rs[i].busy = 0;
            end
            
            // Clear instruction queue
            iq_head = 0;
            iq_tail = 0;
            for (integer i = 0; i < 16; i = i + 1) begin
                instruction_queue[i] = 0;
            end
        end
    end
    
    // Main simulation loop
    always @(posedge clk) begin
        if (reset) begin
            // Reset logic
            clock_cycles <= 0;
        end else begin
            clock_cycles <= clock_cycles + 1;
            
            // Pipeline stages
            issue_stage();
            execute_stage();
            writeback_stage();
            
            // Update performance counters
            print_performance();
        end
    end
    
    // Issue stage - dispatch instructions to reservation stations
    task issue_stage;
        reg [31:0] current_instr;
        reg [4:0] opcode;
        reg [2:0] dest, src1, src2;
        reg [15:0] imm;
        integer rs_found;
    begin
        if (iq_head != iq_tail) begin  // Instructions in queue
            current_instr = instruction_queue[iq_head];
            opcode = current_instr[31:27];
            dest = current_instr[26:24];
            src1 = current_instr[23:21];
            src2 = current_instr[20:18];
            imm = current_instr[15:0];
            
            // Find available RS
            rs_found = 0;
            for (integer i = 0; i < NUM_RS; i = i + 1) begin
                if (!rs[i].busy) begin
                    // Mark RS as busy
                    rs[i].busy = 1;
                    rs[i].opcode = opcode;
                    rs[i].dest = dest;
                    
                    // Check operand availability
                    if (reg_status[src1] == 0) begin
                        rs[i].vj = registers[src1];
                        rs[i].qj = 0;
                    end else begin
                        rs[i].vj = 0;
                        rs[i].qj = reg_status[src1];
                    end
                    
                    if (opcode != OP_LOAD && opcode != OP_STORE) begin
                        if (reg_status[src2] == 0) begin
                            rs[i].vk = registers[src2];
                            rs[i].qk = 0;
                        end else begin
                            rs[i].vk = 0;
                            rs[i].qk = reg_status[src2];
                        end
                    end
                    
                    // For memory ops
                    if (opcode == OP_LOAD || opcode == OP_STORE) begin
                        rs[i].address = registers[src1] + imm;
                    end
                    
                    // Set execution time
                    case (opcode)
                        OP_LOAD:  rs[i].cycles_left = 6;
                        OP_STORE: rs[i].cycles_left = 6;
                        OP_ADD:  rs[i].cycles_left = 2;
                        OP_MUL:  rs[i].cycles_left = 10;
                        OP_BEQ:  rs[i].cycles_left = 1;
                        default:  rs[i].cycles_left = 0;
                    endcase
                    
                    // Update register status
                    if (opcode != OP_STORE && opcode != OP_BEQ) begin
                        reg_status[dest] = i + 1;  // RS index + 1 (0 means no writer)
                    end
                    
                    // Remove instruction from queue
                    iq_head = iq_head + 1;
                    rs_found = 1;
                    break;
                end
            end
            
            if (!rs_found) begin
                $display("Cycle %0d: No RS available for instruction", clock_cycles);
            end
        end
    end
    endtask
    
    // Execute stage - process operations in reservation stations
    task execute_stage;
        reg [15:0] operand1, operand2;
    begin
        for (integer i = 0; i < NUM_RS; i = i + 1) begin
            if (rs[i].busy && rs[i].cycles_left > 0) begin
                // Check if operands are ready
                if (rs[i].qj == 0 && rs[i].qk == 0) begin
                    rs[i].cycles_left = rs[i].cycles_left - 1;
                    
                    if (rs[i].cycles_left == 0) begin
                        // Perform the operation
                        case (rs[i].opcode)
                            OP_ADD: begin
                                rs[i].result = rs[i].vj + rs[i].vk;
                            end
                            OP_MUL: begin
                                rs[i].result = rs[i].vj * rs[i].vk;
                            end
                            OP_LOAD: begin
                                rs[i].result = memory[rs[i].address];
                            end
                            OP_STORE: begin
                                memory[rs[i].address] = rs[i].vj;
                            end
                            OP_BEQ: begin
                                branches = branches + 1;
                                // Simplified branch prediction (always not taken)
                                if (rs[i].vj == rs[i].vk) begin
                                    mispredictions = mispredictions + 1;
                                end
                            end
                        endcase
                    end
                end
            end
        end
    end
    endtask
    
    // Writeback stage - write results to registers/CDB
    task writeback_stage;
    begin
        for (integer i = 0; i < NUM_RS; i = i + 1) begin
            if (rs[i].busy && rs[i].cycles_left == 0) begin
                // Write result to register (except for store/branch)
                if (rs[i].opcode != OP_STORE && rs[i].opcode != OP_BEQ) begin
                    registers[rs[i].dest] = rs[i].result;
                end
                
                // Clear register status
                if (rs[i].opcode != OP_STORE) begin
                    reg_status[rs[i].dest] = 0;
                end
                
                // Free the reservation station
                rs[i].busy = 0;
                instructions_completed = instructions_completed + 1;
            end
        end
    end
    endtask
    
    // Performance reporting
    task print_performance;
        real ipc, mispred_rate;
    begin
        ipc = (instructions_completed * 1.0) / (clock_cycles * 1.0);
        mispred_rate = (branches > 0) ? (mispredictions * 100.0) / (branches * 1.0) : 0;
        
        $display("=== Simulation Cycle %0d ===", clock_cycles);
        $display("Instructions completed: %0d", instructions_completed);
        $display("IPC: %0.2f", ipc);
        $display("Branches: %0d, Mispredictions: %0d (%.1f%%)", 
                branches, mispredictions, mispred_rate);
        $display("--------------------------");
    end
    endtask
    
    // Helper function to load program
    task load_program;
        input [31:0] program [0:15];
        input [3:0] program_size;
    begin
        for (integer i = 0; i < program_size; i = i + 1) begin
            instruction_queue[i] = program[i];
        end
        iq_tail = program_size;
    end
    endtask
    
endmodule
