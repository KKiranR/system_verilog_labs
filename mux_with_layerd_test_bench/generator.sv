//`include "transaction.sv"
class generator;
  rand transaction trans;
  mailbox gen2driv;
  int repeat_count;
  function new(mailbox gen2driv);
    this.gen2driv=gen2driv;
  endfunction
  task main;
    repeat(repeat_count)begin
      trans =new();
      if(!trans.randomize()) $display("randomization faliled");
      gen2driv.put(trans);
    end
    
  endtask
    endclass