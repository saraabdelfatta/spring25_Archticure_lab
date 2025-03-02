`timescale 1ns / 1ps


module ALU#(n = 32)(
    //Two n-bit inputs for the operands.
    input [n-1:0] a,
    input [n-1:0] b,
    
    //A 4-bit control signal that determines the operation to be performed.
    input [3:0] sel,

    //A flag that is set to 1 if the result of the operation is zero, otherwise 0.
    output reg zeroFlag,

    //The result of the operation, which is n+1 bits wide (to accommodate overflow in arithmetic operations).
    output reg [n:0] ALU_out
    );

    //A wire to store the result of the addition operation.
    wire [n-1:0] sum;

    //A wire to store either b or its complement (~b), depending on the operation.
    wire [n-1:0] b_twos;
    
    //This line assigns b_twos based on the value of sel:
    //--> If sel is 4'b0010 (binary 0010), b_twos is assigned the value of b.
    //--> Otherwise, b_twos is assigned the bitwise complement of b (~b).
    assign b_twos = (sel[3:0] == 4'b0010) ? b : ~b;

    //This instantiates a Ripple_Carry_Adder module //with n-bit inputs a and b_twos, and a carry-in (cin) set to sel[2].
    //The result of the addition is stored in the sum wire.
    Ripple_Carry_Adder #(.n(n)) RCA (.a(a), .b(b_twos), .cin(sel[2]), .sum(sum));


    //This block defines the behavior of the ALU based on the value of sel:
    //Case 1 (4'b0010): Perform addition (ALU_out = sum).
    //Case 2 (4'b0110): Perform subtraction (ALU_out = sum)
    //Subtraction is achieved by adding a to the two's complement of b (handled by the Ripple_Carry_Adder).
    //Case 3 (4'b0000): Perform bitwise AND (ALU_out = a & b).
    //Case 4 (4'b0001): Perform bitwise OR (ALU_out = a | b).
    //Default Case: If sel does not match any of the above, the output is set to 0.
    always@(*)
    begin
        case(sel)
            4'b0010: ALU_out = sum;
            4'b0110: ALU_out = sum;
            4'b0000: ALU_out = a & b;
            4'b0001: ALU_out = a | b;
            default: ALU_out = 0;
        endcase

        //fter computing ALU_out, the zeroFlag is updated:
        if(ALU_out != 0)
             //-->If ALU_out is non-zero, zeroFlag is set to 0.
            zeroFlag = 0;
        else
             //-->If ALU_out is zero, zeroFlag is set to 1.
            zeroFlag = 1;
    end
endmodule
