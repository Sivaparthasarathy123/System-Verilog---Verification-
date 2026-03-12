// Asynchronous FIFO Verification - Driver
class driver #(DEPTH, WIDTH);
  transaction #(DEPTH, WIDTH) wr_trans;
  transaction #(DEPTH, WIDTH) rd_trans;
  virtual asyn_fifo #(DEPTH, WIDTH) intr;
  mailbox gen2drv_wr;
  mailbox gen2drv_rd;

  // write count & read Count
  int write_count = 0;
  int read_count = 0;
  int total_writes = DEPTH;  
  int total_reads = DEPTH;   
  event wr_done;
  event rd_done;

  function new(virtual asyn_fifo #(DEPTH, WIDTH) intr, mailbox gen2drv_wr, mailbox gen2drv_rd);
    this.intr = intr;
    this.gen2drv_wr = gen2drv_wr;
    this.gen2drv_rd = gen2drv_rd;
  endfunction

  task drv_main;
    fork
      write_driver;
      read_driver;
      begin
        @(wr_done);
        @(rd_done);
        $display("All %0d writes and %0d reads completed from Driver", total_writes, total_reads);
      end
    join
  endtask

  task write_driver;
    forever begin
      // Checking All Writes are done
      if(write_count >= total_writes) begin
        $display("Write driver -> Total Completed %0d writes", write_count);
        ->wr_done;
        break;
      end

      gen2drv_wr.get(wr_trans);  // get new transaction from generator

      // FIFO Full Condition
      if(intr.full) begin
        $display("Time = %0t ----------- FIFO FULL ----------", $time);
        @(intr.wr_drv);
      end

      // Wait for clock edge
      @(intr.wr_drv);
      // Reset Condition
      if(wr_trans.w_rst) begin
        intr.wr_drv.w_rst <= 1;
        intr.wr_drv.w_en <= 0;
        write_count++;
        continue;
      end
      intr.wr_drv.w_en <= 1;
      intr.wr_drv.data_in <= wr_trans.data_in;

      @(intr.wr_drv);
      intr.wr_drv.w_en <= 0;
      wr_trans.display("Write Driver class");
      write_count++;
      $display("Write => %0d -> data = %0d, full = %0b, time = %0t", write_count, wr_trans.data_in, intr.full, $time);
    end
  endtask

  task read_driver;
    forever begin
      // Checking All Reads are done
      if(read_count >= total_reads) begin
        $display("Read driver -> Total Completed %0d reads", read_count);
        ->rd_done;
        break;
      end

      gen2drv_rd.get(rd_trans);  // get new transaction from generator

      // Read Waiting
      while(intr.empty) begin
        $display("Read Waiting - FIFO empty at time %0t, waiting for data", $time);
        @(intr.rd_drv);
      end

      // Reset Condition
      if(rd_trans.r_rst) begin
        intr.rd_drv.r_rst <= 1;
        intr.rd_drv.r_en <= 0;
        read_count++;
        continue;
      end

      // Read Starts
      intr.rd_drv.r_en <= 1;
      intr.rd_drv.r_rst <= 0;

      @(intr.rd_drv);
      rd_trans.data_out = intr.data_out;
      intr.rd_drv.r_en <= 0;
      read_count++;
      $display("Read => %0d -> data = %0d, empty = %0b, time = %0t", read_count, intr.data_out, intr.empty, $time);
    end
  endtask
endclass
