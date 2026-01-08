// Synchronization FIFO Scoreboard
class scoreboard #(DEPTH, WIDTH);
  
  mailbox mon2scb;
  
  bit clk, rst;
  bit [WIDTH-1:0] fifo [$:DEPTH-1];
  bit [WIDTH-1:0] expected;
  bit read_active = 0;
  
  function new (mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction

  task main;
    transaction #(DEPTH, WIDTH) trans;
  
  forever begin
    mon2scb.get(trans);
    $display("--- Scoreboard Check at %0t ---", $time);

    if (read_active) begin
      if (trans.data_out == expected)
        $display("[%0t] [PASS] Exp: %0d, Act: %0d", $time, expected, trans.data_out);
      else
        $error("[%0t] [FAIL] Exp: %0d, Act: %0d", $time, expected, trans.data_out);
      read_active = 0;
    end

    // Write Logic
    if (trans.w_en && !trans.full) begin
      fifo.push_back(trans.data_in);
      $display("[%0t] [Scoreboard] Stored: %0d", $time, trans.data_in);
    end

    // Read Logic 
    if (trans.r_en && !trans.empty) begin
      if (fifo.size() > 0) begin
        expected = fifo.pop_front();
        read_active = 1; 
        $display("[%0t] [Scoreboard] Popped: %0d", $time, expected);
      end
    end
  end
endtask
endclass
