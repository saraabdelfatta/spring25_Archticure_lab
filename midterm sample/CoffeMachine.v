`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2024 01:32:02 PM
// Design Name: 
// Module Name: CoffeMachine
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CoffeMachine(input clk,reset,en, output[3:0] ledState, output reg [3:0]  Anode, output reg [6:0] ssd_out);
wire dividedclk;
clockDivider #(50000000)div(clk,reset,en, dividedclk); 
reg [1:0] current_state;
reg [1:0] next_state;
parameter [1:0] Brew = 2'b00;
parameter [1:0] Steam = 2'b01;
parameter [1:0] Wait = 2'b10;
parameter [1:0] Clean = 2'b11;
reg [3:0] counter=0;
reg [3:0] LED_BCD;
//reg [21:0] refresh_counter2 = 0; // 20-bit counter

reg [19:0] refresh_counter = 0; // 20-bit counter
//assign dividedclk=refresh_counter2[20];

wire [1:0] LED_activating_counter;
always @(posedge dividedclk or posedge reset)
    begin
        if(reset==1'b1 || current_state != next_state)
        counter <= 4'b0000;
        else if (en==1'b1)
        counter <= counter+1;
        else if(en==1'b0)
        counter <= counter;
        
    end
always @(*) begin
        case (current_state)
            Brew: begin
            if(counter== 4'd5)
            next_state <= Steam;
            else
            next_state <=Brew;
            end
            Steam: begin
            if(counter==3'd3)
            next_state <=Wait;
            else
            next_state <=Steam;
            end
            Wait: begin
            if(counter==4'd10)
            next_state <=Clean;
            else
            next_state <=Wait;
            end
            Clean: begin
            if(counter==3'd4)
            next_state <=Brew;
            else
            next_state <=Clean;
            end
            default: current_state <= Brew;
        endcase
end
always @(posedge dividedclk or posedge reset)
    begin
    if(reset==1'b1) 
    current_state <= Brew;
    else
    current_state <= next_state;
    end
//   always @(posedge clk) begin
//        refresh_counter2 <= refresh_counter2 + 1;
//    end

    always @(posedge clk) begin
        refresh_counter <= refresh_counter + 1;
    end

    assign LED_activating_counter = refresh_counter[19:18];

    always @(*) begin
        case(LED_activating_counter)
            2'b00: begin
                Anode = 4'b0111;
                LED_BCD = counter / 1000;
            end
            2'b01: begin
                Anode = 4'b1011;
                LED_BCD = (counter % 1000) / 100;
            end
            2'b10: begin
               Anode = 4'b1101;
                LED_BCD = ((counter % 1000) % 100) / 10;
            end
            2'b11: begin
                Anode = 4'b1110;
                LED_BCD = ((counter % 1000) % 100) % 10;
            end
        endcase
    end

always @(*) begin
        case(LED_BCD)
            4'b0000: ssd_out = 7'b0000001; // "0"
            4'b0001: ssd_out = 7'b1001111; // "1"
            4'b0010: ssd_out = 7'b0010010; // "2"
            4'b0011: ssd_out = 7'b0000110; // "3"
            4'b0100: ssd_out = 7'b1001100; // "4"
            4'b0101: ssd_out = 7'b0100100; // "5"
            4'b0110: ssd_out = 7'b0100000; // "6"
            4'b0111: ssd_out = 7'b0001111; // "7"
            4'b1000: ssd_out = 7'b0000000; // "8"
            4'b1001: ssd_out = 7'b0000100; // "9"
            default: ssd_out = 7'b0000001; // Default to "0"
        endcase
end
assign ledState[0]= (current_state==Brew);
assign ledState[1]= (current_state==Steam);
assign ledState[2]= (current_state==Wait);
assign ledState[3]= (current_state==Clean);

endmodule
