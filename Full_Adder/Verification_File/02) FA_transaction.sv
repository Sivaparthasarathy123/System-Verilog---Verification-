// transaction file
class transaction;
  randc bit a;
  randc bit b;
  randc bit cin;
  
  bit sum;
  bit carry; 
  
  function void display(string msg="");
    $display("%s a=%0d b=%0d cin=%0d | sum=%0d carry=%0d",msg, a, b, cin, sum, carry);
  endfunction
  
endclass
