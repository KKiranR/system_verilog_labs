///////////////////////////////////////////////////////////////////////////
// (c) Copyright 2013 Cadence Design Systems, Inc. All Rights Reserved.
//
// File name   : mem_test.sv
// Title       : Memory Testbench Module
// Project     : SystemVerilog Training
// Created     : 2013-4-8
// Description : Defines the Memory testbench module
// Notes       :
// 
///////////////////////////////////////////////////////////////////////////

module mem_test ( input logic clk, 
                  output logic read, 
                  output logic write, 
                  output logic [4:0] addr, 
                  output logic [7:0] data_in,     // data TO memory
                  input  wire [7:0] data_out     // data FROM memory
                );
// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;

// SYSTEMVERILOG: new data types - bit ,logic
bit         debug = 1;
logic [7:0] rdata;      // stores data read from memory for checking
logic [7:0]read_content;
logic [7:0] write_content;
logic [4:0]i;
// Monitor Results
  initial begin
      $timeformat ( -9, 0, " ns", 9 );
// SYSTEMVERILOG: Time Literals
      #40000ns $display ( "MEMORY TEST TIMEOUT" );
      $finish;
    end

initial
  begin: memtest
  int error_status;

    $display("Clear Memory Test");

    for (int i = 0; i< 32; i++)
       // Write zero data to every address location
	@(negedge clk)write_mem(0,i);
    for (int i = 0; i<32; i++)
      begin 
       // Read every address location
	@(negedge clk) read_mem(rdata,i);
       // check each memory location for data = 'h00
	if(rdata!=8'h0)
		$display("failed writing zero");
	else if(rdata===8'h0)
		$display("cleared memory sucessfully");
      end

   // print results of test

    $display("Data = Address Test");

    for (int i = 0; i< 32; i++)
       // Write data = address to every address location
begin
       {write_content}=8'b11101001;@(negedge clk) write_mem(write_content,i);
end
error_status=100;
    
    #100
    for (int i = 0; i<32; i++)
      begin
       // Read every address location
	@(negedge clk)read_mem(read_content,i);
        print_check(read_content,write_content);
      end
    $finish;
  end
task read_mem(output logic [7:0]dataout,input logic [4:0]addr1);
assign read=1;
assign write=0;
assign addr=addr1;
assign dataout=data_out;
endtask 
// add read_mem and write_mem tasks
task write_mem(input logic [7:0]datain,input logic [4:0]addr1);
assign write=1;
assign read=0;
assign addr=addr1;
assign data_in=datain;
endtask
// add result print function
  function void print_check(logic [7:0] read_content, logic [7:0] written_content);
    if(read_content==written_content)
      $display("sucessful for the data_in=%b and data_out=%b",read_content,written_content);
    else if (read_content!==written_content)
      $display("read_data dosent match data_in=%b and data_out=%b",read_content,written_content);
    endfunction : print_check
endmodule

