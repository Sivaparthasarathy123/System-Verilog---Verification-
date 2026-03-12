// Asynchronous FIF0 Verifiaction - Environment
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment #(DEPTH, WIDTH);
  transaction #(DEPTH, WIDTH) trans;
  generator #(DEPTH, WIDTH) gen;
  driver #(DEPTH, WIDTH) driv;
  monitor #(DEPTH, WIDTH) mon;
  scoreboard #(DEPTH, WIDTH) score;

  mailbox gen2drv_wr;
  mailbox gen2drv_rd;
  mailbox mon2scb_wr;
  mailbox mon2scb_rd;
  event wr_ended;
  event rd_ended;
  
  virtual asyn_fifo #(DEPTH, WIDTH) intr;

  // Done Signal
  bit write_done = 0;
  bit read_done = 0;

  function new (virtual asyn_fifo #(DEPTH, WIDTH) intr);
    this.intr = intr;

    gen2drv_wr = new();
    gen2drv_rd = new();
    mon2scb_wr = new();
    mon2scb_rd = new();

    gen = new(gen2drv_wr, gen2drv_rd, wr_ended, rd_ended);
    driv = new(intr, gen2drv_wr, gen2drv_rd);
    mon = new(intr, mon2scb_wr, mon2scb_rd);
    score = new(intr, mon2scb_wr, mon2scb_rd, wr_ended, rd_ended);

    gen.wr_ended = wr_ended;
    gen.rd_ended = rd_ended;
    score.wr_ended = wr_ended;
    score.rd_ended = rd_ended;
  endfunction

  task run_main;
    fork
      begin
        gen.gen_main;
        $display("Environment -> Generator completed");
      end
      
      begin
        driv.drv_main;
        $display("Environment -> Driver completed");
        write_done = 1;
        read_done = 1;
      end
      
      begin
        mon.mon_main;
        $display("Environment -> Monitor completed");
      end
      
      begin
        score.scb_main;
        $display("Environment -> Scoreboard completed");
      end
      
      // Completion detector
      begin
        wait(write_done && read_done);
        $display("----------- All transactions completed -----------");
        #1000;
        
        // Report
        $display("\n----------------------------------------------");
        $display("----- SIMULATION COMPLETED SUCCESSFULLY ------");
        $display("------------------------------------------------");
        $display("Total Writes Generated   -> %0d", gen.write_count);
        $display("Total Reads Generated    -> %0d", gen.read_count);
        $display("Writes Processed         -> %0d", driv.write_count);
        $display("Reads Processed          -> %0d", driv.read_count);
        $display("PASS                     -> %0d", score.pass_count);
        $display("FAIL                     -> %0d", score.fail_count);
        $display("Expected Queue Remaining -> %0d", score.expected_queue.size());
        $display("-----------------------------------------------\n");
        
        $finish;
      end
      
      begin
        #200000;  
        $display("Time = %0t ------- TIMEOUT ERROR --------", $time);
        $display("Write count -> %0d/%0d, Read count -> %0d/%0d", driv.write_count, gen.write_count, driv.read_count, gen.read_count);
        $display("Expected queue size -> %0d", score.expected_queue.size());
        $finish;
      end
    join
  endtask
endclass
