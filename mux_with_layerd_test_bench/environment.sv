//`include "transaction.sv"
//`include "generator.sv"
//`include "interface.sv"
//`include "driver.sv"
class environment;
  generator gen;
 	driver driv;
  virtual inter vif;
  mailbox gen2driv;
  function new(virtual inter vif);
    this.vif=vif;
    gen2driv=new();
    gen=new(gen2driv);
    driv=new(vif,gen2driv);
  endfunction
  task pre_test;
    driv.reset();
  endtask
  task test;
    fork 
      gen.main();
      driv.main();
    join_any;
  endtask
  task run;
    pre_test();
    test();
    #200
    $finish;
  endtask
    endclass