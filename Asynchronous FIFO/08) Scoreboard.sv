// Asynchronous FIFO Verification - Scoreboard
class scoreboard #(DEPTH, WIDTH);
  transaction #(DEPTH, WIDTH) wr_trans;
  transaction #(DEPTH, WIDTH) rd_trans;
  virtual asyn_fifo #(DEPTH, WIDTH) intr; 
  mailbox mon2scb_wr;
  mailbox mon2scb_rd;

  // Expected FIFO
  bit [WIDTH-1:0] expected_queue[$];
  bit [WIDTH-1:0] expected_data;

  int pass_count = 0;
  int fail_count = 0;
  int read_count = 0;  

  event wr_ended;
  event rd_ended;

  function new(virtual asyn_fifo #(DEPTH, WIDTH) intr, mailbox mon2scb_wr, mailbox mon2scb_rd, event wr_ended, rd_ended);
    this.intr = intr;
    this.mon2scb_wr = mon2scb_wr;
    this.mon2scb_rd = mon2scb_rd;
    this.wr_ended = wr_ended;
    this.rd_ended = rd_ended;
  endfunction

  task scb_main;
    fork
      write_checker;
      read_checker;
    join
  endtask

  task write_checker;
    forever begin
      mon2scb_wr.get(wr_trans);

      if (wr_trans.w_rst) begin
        expected_queue.delete();
        $display("Time = %0t | Scoreboard => Reset -> queue cleared", $time);
      end
      else if (wr_trans.w_en && !wr_trans.full) begin
        expected_queue.push_back(wr_trans.data_in);
        $display("Time = %0t | Scoreboard Wite => Pushed -> %0d | Size -> %0d\n", wr_trans.data_in, expected_queue.size(), $time);
      end
      
      wr_trans.display("Write checker Scoreboard Class");
      ->wr_ended;
    end
  endtask

  task read_checker;
    forever begin
      mon2scb_rd.get(rd_trans);

      // Read Reset Condition
      if (rd_trans.r_rst) begin
        expected_queue.delete();
        $display("Time = %0t | Scoreboard Reset -> queue cleared", $time);
        rd_trans.display("Read Checker Scoreboard Class");
        ->rd_ended;
      end
      // Read Count
      read_count++;

      // $display("Time = %0t | Scoreboard_Checker -> Read => %0d received , data=%0d, empty=%0b", read_count, $time, rd_trans.data_out, rd_trans.empty);

      if (expected_queue.size() > 0) begin
        expected_data = expected_queue.pop_front();

        if (rd_trans.data_out === expected_data) begin
          $display("Time = %0t | [%0d] -------------- PASS ------------  Got -> %0d, Expected -> %0d, Queue left -> %0d\n", $time, read_count, rd_trans.data_out, expected_data, expected_queue.size());
          pass_count++;
        end
        else begin
          $error("Time = %0t | [%0d] -------------- FAIL ------------  Got -> %0d, Expected -> %0d, Queue left -> %0d\n", $time, read_count, rd_trans.data_out, expected_data, expected_queue.size());
          fail_count++;
        end
      end
      else begin
        $error("Time = %0d | [%0d] ------------ QUEUE EMPTY --------- Got -> %0d", $time, read_count, rd_trans.data_out);
      end

      rd_trans.display("Read Checker Scoreboard Class");
      ->rd_ended;
    end
  endtask
endclass
