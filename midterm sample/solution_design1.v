module vending_machine(
    // Clock signal (synchronizes state transitions).
    input clk,

    //Active-low reset (resets the machine to initial state when 0).
    input reset,

    //Active-high signal indicating a coin is inserted (1 = coin inserted).
    input coin_in_en,

    //etermines coin value (0 = 5 cents, 1 = 10 cents).
    input coin_val,

    //Active-high signal to dispense a pencil (1 = dispense).
    output reg pencil_out,

    // Indicates remaining money to return (only 5 cents possible here).
    output reg [2:0] extra_money
);

//4 bits that :: Tracks the total money inserted (max 15 cents needed, so 4 bits suffice).
reg [3:0] current_amount;

//2 bits :: Stores the current state of the FSM (Finite State Machine).
reg [1:0] state;

//Initial state; waits for a coin insertion.
parameter IDLE = 2'b00;

//Accumulates inserted coins until ≥15 cents is reached.
parameter COUNTING = 2'b01;

//Dispenses a pencil and checks for extra money.
parameter DISPENSE = 2'b10;

//Returns extra money (5 cents) if overpaid.
parameter RETURN = 2'b11;

//Main Always Block (State Machine)
//Updates state and outputs synchronously.
always @(posedge clk or negedge reset) begin
    //Resets all registers (current_amount, pencil_out, extra_money) and sets state = IDLE.
    if (!reset) begin
        current_amount <= 0;
        pencil_out <= 0;
        extra_money <= 0;
        state <= IDLE;
    end
    //State Transitions & Logic
    else begin
        case(state)

                //Clears pencil_out and extra_money.
            IDLE: begin
                pencil_out <= 0;
                extra_money <= 0;

                //On coin_in_en, updates current_amount (5 or 10 cents) and moves to COUNTING.
                if (coin_in_en) begin
                    current_amount <= (coin_val) ? 10 : 5;
                    state <= COUNTING;
                end
            end

            //Adds new coins to current_amount when coin_in_en is high.
            COUNTING: begin
             //Adds new coins to current_amount when coin_in_en is high.
                if (coin_in_en) begin
                    current_amount <= current_amount + ((coin_val) ? 10 : 5);
                end
                //Transitions to DISPENSE once ≥15 cents is reached.
                if (current_amount >= 15) begin
                    state <= DISPENSE;
                end
            end

            //Sets pencil_out = 1 (dispense pencil).
            DISPENSE: begin
                //Sets pencil_out = 1 (dispense pencil).
                pencil_out <= 1;

                //If overpaid (>15 cents), sets extra_money = 5 and moves to RETURN.
                //Otherwise, returns to IDLE.
                if (current_amount > 15) begin
                    extra_money <= 5; // Only 5 cents can be remaining based on assumptions
                    state <= RETURN;
                end

                //Otherwise, returns to IDLE.
                else begin
                    state <= IDLE;
                end
            end

            //Clears extra_money (simulating money returned to user).
            RETURN: begin
                extra_money <= 0; // Money returned
                //Returns to IDLE.
                state <= IDLE;
            end
        endcase
    end
end

endmodule
