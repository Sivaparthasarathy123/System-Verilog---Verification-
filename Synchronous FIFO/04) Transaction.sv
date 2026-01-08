// Synchronous FIFO Transaction
class transaction #(DEPTH, WIDTH);
  rand bit w_en;
  rand bit r_en;
  rand bit [WIDTH-1:0] data_in;
  bit      [WIDTH-1:0] data_out;
  bit full;
  bit empty;

  function void display(string name);
    $display(" %0s ", name);
    $display("Time = %0t| Write Enable = %0d| Read Enable = %0d| Data In = %0d| Data Out = %0d| Full = %0d| Empty = %0d", $time, w_en, r_en, data_in, data_out, full, empty);
  endfunction
endclass
  
  
