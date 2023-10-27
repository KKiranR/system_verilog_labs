`include "typedefs.sv"
import typedefs::*;
module alu(
input logic [7:0]accum,
input logic [7:0]data,
opcode_t opcode,
input logic clk,
output logic [7:0]out,
output logic zero
);
reg zero1 ;
reg [7:0]out_acc;
always_ff@(negedge clk )
begin :always_alu
//zero1=0;
case(opcode)
HLT: out_acc=accum;
SKZ:out_acc=accum;
ADD:out_acc=data+accum;
AND:out_acc=data & accum;
XOR:out_acc=data^accum;
LDA:out_acc=data;
STO:out_acc=accum;
JMP:out_acc=accum;
endcase
end:always_alu
always_comb
if(accum==0)
    zero1=1;
else
zero1=0;
assign out = out_acc;
assign zero =zero1;
endmodule
