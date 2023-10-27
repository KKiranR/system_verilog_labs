// Code your testbench here
// or browse Examples
`include "transaction.sv"
`include "generator.sv"
`include "interface.sv"
`include "driver.sv"
`include "environment.sv"
`include "test.sv"
module test_Tb;
  bit clk;
  bit reset;
  inter vif(clk,reset);
  test t1(vif);
  mux dut(.clk(vif.clk),.rst(vif.rst),.a(vif.a),.b(vif.b),.y(vif.y),.sel(vif.sel));
  always #5 clk=~clk;
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,test_Tb);
  end
  initial begin
    clk=0;
    reset=1;
    #5 reset=0;
    #200
    $finish;
  end
endmodule
                                                                