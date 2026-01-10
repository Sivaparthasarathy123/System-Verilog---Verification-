// Asynchronous FIFO Verification - Scoreboard
         
class scoreboard #(DEPTH, WIDTH);
  mailbox mon2scb;
  
  bit [WIDTH-1:0] expected_queue[$:DEPTH-1]; 
  
  int pass_count = 0;
  int fail_count = 0;
  bit [WIDTH-1:0] expected_data;

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction

  task scb_main;
  transaction #(DEPTH, WIDTH) trans;
  forever begin
    mon2scb.get(trans);

    // Delete the Reset Queue 
    if (trans.w_rst || trans.r_rst) begin
      expected_queue.delete(); 
      $display("[SCB_RESET] Time=%0t | Queue Cleared", $time);
    end 
    else begin
    // Checking the Full Condition and Writing the Data
    if (trans.w_en && !trans.full) begin
      expected_queue.push_back(trans.data_in);
      $display("[SCB_WRITE] Time=%0t | Data In: %0d", $time, trans.data_in);
    end

     // Checking the Empty Condition and Read the Data
     if (trans.r_en && !trans.empty) begin
       if (expected_queue.size() > 0) begin
         expected_data = expected_queue.pop_front();
         if (trans.data_out == expected_data)
           $display("[SCB_PASS] Got: %0d", trans.data_out);
         else
           $display("[SCB_FAIL] Got: %0d | Exp: %0d", trans.data_out, expected_data);
        end
      end
    end
  end
 endtask
endclass
         
