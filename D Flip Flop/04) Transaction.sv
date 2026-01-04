// Transaction D Flip Flop
class transaction;
  rand bit rst;
  rand bit d;
  bit q;
  
  function void display(string name);
    $display(" %0s ",name);
    $display("Reset = %0b| Input D = %0b| output Q = %0b", rst, d, q);
  endfunction 
endclass
