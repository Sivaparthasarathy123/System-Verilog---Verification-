// Transaction - Dual Port RAM
class ram_transaction #(parameter DEPTH = 8, WIDTH = 8);
    rand bit w_en_a, w_en_b;
    rand bit [$clog2(DEPTH)-1:0] addr_a, addr_b;
    rand bit [WIDTH-1:0] data_in_a, data_in_b;
    bit      [WIDTH-1:0] data_out_a, data_out_b;
  
  function void display (string name);
    $display("---%s---",name);
    $display("Time = %0t | Write Enable A = %0b | Write Enable B = %0b | Address A = %0d | Address B = %0d | Data In A = %d | Data In B = %d | Data Out A = %0d | Data Out B = %0d", $time, w_en_a, w_en_b, addr_a, addr_b, data_in_a, data_in_b, data_out_a, data_out_b);
  endfunction

endclass
