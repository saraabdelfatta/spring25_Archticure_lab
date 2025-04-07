module vending_machine(
    input clk,
    input reset,
    input coin_in_en,
    input coin_val,
    
    output reg pencil_out,
    output reg [2:0] extra_money
);

reg [3:0] current_amount;
reg [1:0] state;

parameter IDLE = 2'b00;
parameter COUNTING = 2'b01;
parameter DISPENSE = 2'b10;
parameter RETURN = 2'b11;

always @(posedge clk or negedge reset) begin
    if (!reset) begin
        current_amount <= 0;
        pencil_out <= 0;
        extra_money <= 0;
        state <= IDLE;
    end
    else begin
        case(state)
            IDLE: begin
                pencil_out <= 0;
                extra_money <= 0;
                if (coin_in_en) begin
                    current_amount <= (coin_val) ? 10 : 5;
                    state <= COUNTING;
                end
            end
            
            COUNTING: begin
                if (coin_in_en) begin
                    current_amount <= current_amount + ((coin_val) ? 10 : 5);
                end
                
                if (current_amount >= 15) begin
                    state <= DISPENSE;
                end
            end
            
            DISPENSE: begin
                pencil_out <= 1;
                if (current_amount > 15) begin
                    extra_money <= 5; // Only 5 cents can be remaining based on assumptions
                    state <= RETURN;
                end
                else begin
                    state <= IDLE;
                end
            end
            
            RETURN: begin
                extra_money <= 0; // Money returned
                state <= IDLE;
            end
        endcase
    end
end

endmodule
