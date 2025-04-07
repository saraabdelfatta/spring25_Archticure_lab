//Code Example 1: Moore FSM to detect two successive ones (1’s) 
//the need tools for this experments is clck, rest, input and output
module fsm(input clk, rst, w, output z);  
  //w is the inpt
  //z is the output

  //are to intilize the current and next state
  reg [1:0] state, nextState;  

  //are the parameter of the question
  //is differ from one question to another
  //start from here is the core of the question
  parameter [1:0] A=2’b00, B=2’b01, C=2’b10; // States Encoding  

// Next state generation (combinational logic) 
  //in this block we depend on the input and the current state
  always @(w or state)
    case(state)
      A:if(w==0)
        nextState = A;
      else
        nextState = B;
      B:if(w==0)
        nextState = A;
      else
        nextState = C;
      C:if(w==0)
        nextState = A;
      else
        nextState = C;
      default: nextState = A;
      endcase 
// Update state FF’s with the triggering edge of the clock 
always @ (posedge clk or posedge rst) begin 
if(rst) 
state <= A; 
state <= nextState; 
// output generation (combinational logic) 
assign z = (state == C); 
endmodule 
