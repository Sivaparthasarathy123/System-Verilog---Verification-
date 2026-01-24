// Transaction - Single Port RAM
class ram_transaction #(parameter DEPTH = 8, WIDTH = 8);
    rand bit w_en;
    rand bit [$clog2(DEPTH)-1:0] addr;
    rand bit [WIDTH-1:0] data_in;
    bit      [WIDTH-1:0] data_out;
  
  function void display (string name);
    $display("---%s---",name);
    $display("Time = %0t | Write Enable = %0b | Address = %0h | Data In = %0h | Data Out = %0h", $time, w_en, addr, data_in, data_out);
  endfunction

endclass
