Code Example 1: Moore FSM to detect two successive ones (1’s) 
module fsm(input clk, rst, w, output z); 
reg [1:0] state, nextState; 
parameter [1:0] A=2’b00, B=2’b01, C=2’b10; // States Encoding 
// Next state generation (combinational logic) 
always @ (w or state) 
case (state) 
A: if (w==0) 
nextState = A; 
else   
B: if (w==0)  
else   
C: if (w==0)  
else   
default:   
endcase 
// State register 
else  
end 
nextState = B; 
nextState = A; 
nextState = C; 
nextState = A; 
nextState = C; 
nextState = A; 
// Update state FF’s with the triggering edge of the clock 
always @ (posedge clk or posedge rst) begin 
if(rst) 
state <= A; 
state <= nextState; 
// output generation (combinational logic) 
assign z = (state == C); 
endmodule 
