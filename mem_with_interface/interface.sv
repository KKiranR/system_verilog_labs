interface bus (input logic clk);
logic[7:0] data_in,data_out;
logic [4:0] addr;
logic read;
logic write;
modport  test(output data_in ,addr,read,write, input data_out);
modport des(input data_in,addr,read,write, output data_in);
endinterface 
