// Asynchronous FIFO Verification - Transaction
class transaction #(DEPTH, WIDTH);
  
  // Transaction Data
  bit w_clk, r_clk;
  rand bit w_rst, r_rst;
  rand bit w_en, r_en;
  rand bit [WIDTH - 1:0] data_in;
  bit      [WIDTH - 1:0] data_out;
  bit full;
  bit empty;
    
  function void display(string name);
  $display("---- %0s ----", name); 
  $display("Time = %0t | w_rst = %0b | r_rst = %0b | w_en = %0b | r_en = %0b | Data in = %0d (%0b) | Data out = %0d (%0b) | Full = %0b | Empty = %0b", 
    $time, w_rst, r_rst, w_en, r_en, data_in, data_in, data_out, data_out, full, empty);
endfunction
  
endclass
