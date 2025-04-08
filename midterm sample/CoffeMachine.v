`timescale 1ns / 1ps

//clk is the clock
//rest is the rest theta return everthing to its orginal value
//en is the enable for the clockdivider
//ledsate is to stor the final answer
//anode and ssd_out are for the FBGA
module CoffeMachine(input clk,reset,en, output[3:0] ledState, output reg [3:0]  Anode, output reg [6:0] ssd_out);
    //important wire for the clock divider
    wire dividedclk;  

    //first:: intillize the clock divider 
    clockDivider #(50000000)div(clk,reset,en, dividedclk); 

    //the current_state that the the pointer refare to 
    reg [1:0] current_state; 

    // the next step the pointer should going to 
    reg [1:0] next_state; 

    //becouse I have 4 states so I have 4 parameters
    //we assign for each states a number as we map for each state a number
    //in other words, brew -->0, steam-->1, wait-->2, and clean -->3
    //this how verlog understand it, therfore, if we have more parametwers we tend to add more bits
    //a coffee machine which has 4 states, brew (5 secs), steam (3 secs), wait (10 secs) and clean (4 secs)
    parameter [1:0] Brew = 2'b00; //5 sec
    parameter [1:0] Steam = 2'b01; //3sec
    parameter [1:0] Wait = 2'b10; //10sec
    parameter [1:0] Clean = 2'b11; //4sec

      //refare to the input and it is for FSM and its 4 bit becouse we have 4 parameter 
      //instead of num in the orginal experments
      reg [3:0] counter=0;
    
        //FBGA
       reg [3:0] LED_BCD;
    
//reg [21:0] refresh_counter2 = 0; // 20-bit counter
    
    reg [19:0] refresh_counter = 0; // 20-bit counter 
    
//assign dividedclk=refresh_counter2[20];
    wire [1:0] LED_activating_counter; 

        //counter 
    //is going to increament at every postive edge of the clock of the clock divider
    //this mean that it will increament every second and that what we want
    //counter is 4 becouse we have 4 statues 
    //it used to move from one state to another
    //whenever the enable = 1------>count
    //it will rest under two condtioned 
    //1. if I reached to my desired number 
    //2. rest the hole module with ashenchrouns
    //if the enable is not ON then the counter is freze
always @(posedge dividedclk or posedge reset)
    begin
        if(reset==1'b1 || current_state != next_state)
        counter <= 4'b0000;
        else if (en==1'b1)
        counter <= counter+1;
        else if(en==1'b0)
        counter <= counter;
        
    end

    //when we have a k steatment 
//when we have case on the current state, and we define the transtion between the states 
    //define the tranxition

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
