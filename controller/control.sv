///////////////////////////////////////////////////////////////////////////
// (c) Copyright 2013 Cadence Design Systems, Inc. All Rights Reserved.
//
// File name   : control.sv
// Title       : Control Module
// Project     : SystemVerilog Training
// Created     : 2013-4-8
// Description : Defines the Control module
// Notes       :
// 
///////////////////////////////////////////////////////////////////////////

// import SystemVerilog package for opcode_t and state_t

import typedefs ::*;
module control  (
	
                output logic      load_ac ,
                output logic      mem_rd  ,
                output logic      mem_wr  ,
                output logic      inc_pc  ,
                output logic      load_pc ,
                output logic      load_ir ,
                output logic      halt    ,
                input  opcode_t opcode  , // opcode type name must be opcode_t
                input             zero    ,
                input             clk     ,
                input             rst_   
                
                );
// SystemVerilog: time units and time precision specification
state_t state;
timeunit 1ns;
timeprecision 100ps;
reg [2:0]current_state;
reg reg_load_ac,reg_mem_rd,reg_mem_wr,reg_inc_pc,reg_load_pc,reg_load_ir,reg_halt,ALUOP;
always_ff @(posedge clk or negedge rst_)
  if (!rst_)
	begin: if_state_always
     state=state.first();
     //$display("state:%b",current_state);
end : if_state_always
  else
begin : else_state_always
     state=state.next();
	$display("state:%b",current_state);
end :else_state_always
always_comb
begin:alwy
case(state)
INST_ADDR: begin : zero1
reg_load_ac=0;
reg_mem_rd=0;
reg_mem_wr=0;
reg_inc_pc=0;
reg_load_pc=0;
reg_load_ir=0;
reg_halt=0;
end:zero1
INST_FETCH:begin:first
reg_mem_rd=1;
reg_load_ac=0;
reg_mem_wr=0;
reg_inc_pc=0;
reg_load_pc=0;
reg_load_ir=0;
reg_halt=0;
end:first
INST_LOAD:begin:second
reg_mem_rd=1;
reg_load_ir=1;
reg_load_ac=0;
reg_mem_wr=0;
reg_inc_pc=0;
reg_load_pc=0;
reg_halt=0;
end:second
IDLE:begin:third
reg_mem_rd=1;
reg_load_ir=1;
reg_load_ac=0;
reg_mem_wr=0;
reg_inc_pc=0;
reg_load_pc=0;
reg_halt=0;
end:third
OP_ADDR:begin:fourth
if(opcode==HLT)
    reg_halt=1;    
reg_inc_pc=1;
reg_load_ac=0;
reg_mem_rd=0;
reg_mem_wr=0;
reg_load_pc=0;
reg_load_ir=0;
end:fourth
OP_FETCH:begin:fifth
if((opcode==AND)||(opcode==ADD)||(opcode==XOR)||(opcode==LDA))
    reg_mem_rd=1;
else
    reg_mem_rd=0;
reg_load_ac=0;
reg_mem_wr=0;
reg_inc_pc=0;
reg_load_pc=0;
reg_load_ir=0;
reg_halt=0;
end:fifth
ALU_OP:begin:sixth
if((opcode==AND)||(opcode==ADD)||(opcode==XOR)||(opcode==LDA))
begin
    reg_mem_rd=1;
    reg_load_ac=1;
    end
else
begin
    reg_mem_rd=0;
    reg_load_ac=0;
    end
if(opcode==SKZ)
    begin
    if(zero==1'b1)
	   reg_inc_pc=1;
	end
else
	reg_inc_pc=0;
if(opcode==JMP)
begin
	reg_load_pc=1;
	end
else
begin
	reg_load_pc=0;
	end
reg_load_ir=0;
reg_halt=0;
reg_mem_wr=0;
end:sixth
STORE:begin:seventh
if((opcode==AND)||(opcode==ADD)||(opcode==XOR)||(opcode==LDA))
begin
reg_load_ac=1;
    reg_mem_rd=1;
end
else
begin
reg_load_ac=0;
    reg_mem_rd=0;
end
reg_load_ir=0;
reg_halt=0;
if(opcode==JMP)
	begin:if_
	reg_inc_pc=1;
	reg_load_pc=1;
	end:if_
else
begin:else_
reg_inc_pc=0;
	reg_load_pc=0;
end:else_
if(opcode==STO)
reg_mem_wr=1;
end:seventh
endcase
end:alwy
assign load_ac = reg_load_ac;
assign mem_rd = reg_mem_rd;
assign mem_wr=reg_mem_wr;
assign inc_pc=reg_inc_pc;
assign load_pc =reg_load_pc;
assign load_ir=reg_load_ir;
assign halt = reg_halt;
//assign state = current_state;
endmodule
