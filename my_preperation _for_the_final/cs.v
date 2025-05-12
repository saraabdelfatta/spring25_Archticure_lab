module cascaded_summation_pipelined #(parameter w=16)( input clk, input rest, input [w-1:0] data[0;3], input[w-1:0] we, output[w-1:0] out);
  wire[w-1:0] mr1 [0:3];
  wire[w-1:0] mr2 [0:3];

  genvar i;

   generate 
     for (i = 0; i < 4; i = i + 1) begin
       assign mr1[i]= we[i]*data[i];
    end
    endgenerate

  N_bit_reg #(w+w+w+w) reg1(clck, rest, 1'b1, {mr1[3], mr1[2], mr1[1], mr1[0]},  {mr2[3], mr2[2], mr2[1], mr2[0]});

  wire[w-1:0] AD1 [0:1];
  wire[w-1:0] AD2 [0:1];

  assign AD1[0]= mr2[1] + mr2[0];
  assign AD1[1]= mr2[2] + mr2[3];

  N_bit_reg #(w+w) reg2(clck, rest, 1'b1, {AD1[0], AD1[1]},  {AD2[0], AD2[1]});
  

  assign out = AD2[0] + AD2[1];
endmodule
  
