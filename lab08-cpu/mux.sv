
module scale_mux #(parameter width=1)(

input logic  [width-1:0]in_a,
input logic [width-1:0]in_b,
output logic[width-1:0]out,
input logic sel_a
);

reg [width-1:0]reg_out;
always_comb
begin : case_a
case(sel_a)
1:reg_out = in_a;
0:reg_out = in_b;
endcase
end : case_a
assign out=reg_out;
endmodule


