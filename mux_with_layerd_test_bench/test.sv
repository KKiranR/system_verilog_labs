//`include "transaction.sv"
//`include "generator.sv"
//`include "interface.sv"
//`include "driver.sv"
//`include "environment.sv"
//`include "testbench.sv"
program test(inter vif);
  environment env;
  initial begin 
    env= new(vif);
    env.gen.repeat_count=100;
    env.run();
  end
endprogram