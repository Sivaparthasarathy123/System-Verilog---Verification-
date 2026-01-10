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
  
  mailbox gen2drv;
  mailbox mon2scb;
  
  virtual asyn_fifo #(DEPTH, WIDTH) intr;
  
  function new (virtual asyn_fifo #(DEPTH, WIDTH) intr);
    this.intr = intr;
  
  
  gen2drv = new();
  mon2scb = new();
  
  gen=new(gen2drv);
  driv=new(intr,gen2drv);
  mon=new(intr,mon2scb);
  score=new(mon2scb);
  
  endfunction
  
  task run_main;
    fork
      gen.gen_main;
      driv.drv_main;
      mon.mon_main;
      score.scb_main;
    join
  endtask
  
endclass
