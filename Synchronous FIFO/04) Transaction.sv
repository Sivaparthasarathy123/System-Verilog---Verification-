// Synchronous FIFO Transaction
class transaction #(parameter DATA_WIDTH = 8);
  rand bit w_en;
  rand bit r_en;
  rand bit [DATA_WIDTH-1:0] data_in;
  rand bit [DATA_WIDTH-1:0] data_out;
  rand bit full;
  rand bit empty;
  
  function void display(string name);
    $display(" %0s ", name);
    $display("Time = %0t| Write Enable = %0d| Read Enable = %0d| Data In = %0d| Data Out = %0d| Full = %0d| Empty = %0d", $time, w_en, r_en, data_in, data_out, full, empty);
  endfunction
endclass
  
  
