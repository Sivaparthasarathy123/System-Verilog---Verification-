// Counter Transaction
class transaction;
  rand bit rst;
  rand bit en;
  bit [2:0]q;
  
  function void display(string name);
    $display("%0s",name);
    $display("Time = %0t| Reset = %0b| Enable = %0b| Output Q = %0d",$time, rst, en, q);
  endfunction
  
endclass
