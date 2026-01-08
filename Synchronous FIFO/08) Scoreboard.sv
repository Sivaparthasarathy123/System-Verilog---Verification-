// Synchronization FIFO Scoreboard
class scoreboard;
  mailbox mon2scb;
  bit [7:0] data_queue[$]; 
  int errors = 0;

  function new (mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction
  
  task main;
    transaction trans;
    forever begin
      mon2scb.get(trans);
      
      // Data Writing and Full Condition
      if (trans.w_en && !trans.full) begin
        data_queue.push_back(trans.data_in);
        $display("[Scoreboard] Data Stored: %0d", trans.data_in);
      end
      
      // Data Reading and empty condition
      if (trans.r_en && !trans.empty) begin
        bit [7:0] expected_data;
        expected_data = data_queue.pop_front();
        
      if (trans.data_out == expected_data) begin
        $display("[Scoreboard] PASS Data Match: Exp = %0d, Act = %0d", expected_data, trans.data_out);
        end else begin
          $error("[Scoreboard] FAIL Data Mismatch: Exp = %0d, Act = %0d", expected_data, trans.data_out);
          errors++;
        end
      end
    end
  endtask
endclass
