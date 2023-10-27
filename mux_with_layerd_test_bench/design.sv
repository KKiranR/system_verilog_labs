// Code your design here
module mux( a,b,y,sel,clk,rst);
  input logic [5:0]a;
  input logic [5:0]b;
  input logic sel;
  output logic [5:0]y;
  input logic rst,clk;
  logic [5:0] reg_y;
  always@(posedge clk)
    begin 
      if(rst)
        y=0;
      else
     	y=sel?a:b;
    end
  //assign y = reg_y;
endmodule