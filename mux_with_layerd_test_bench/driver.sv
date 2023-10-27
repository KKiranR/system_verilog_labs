//`include "interface.sv"
//`include "transaction.sv"
class driver;
  mailbox gen2driv;
  virtual inter vif;
  function new(virtual inter vif, mailbox gen2driv);
    this.vif=vif;
    this.gen2driv=gen2driv;
  endfunction
  task reset;
    wait(vif.rst);
    $display("------reset started--------");
    vif.a<=0;
    vif.b<=0;
    vif.sel<=0;
    wait(!vif.rst);
    $display("-----reset completed-------");
  endtask
  task main;
    forever begin
    transaction trans;
      //$display("------in driver-------");
    gen2driv.get(trans);
    vif.a=trans.a;
    vif.b=trans.b;
    vif.sel=trans.sel;
    @(posedge vif.clk);
    trans.y=vif.y;
      trans.display();
    end
  endtask
endclass