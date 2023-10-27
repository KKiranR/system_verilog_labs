class transaction;
  rand bit [5:0]a;
  rand bit [5:0]b;
  rand bit sel;
  bit [5:0]y;
  function void display();
    $display("------------Outputs---------------");
    $display("\t a=%d ,b =%d,sel=%d\t",a,b,sel);
    $display("\t y=%d\t",y);
  endfunction
endclass