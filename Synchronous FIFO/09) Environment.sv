// Synchronous FIFO Environment
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  transaction trans;
  generator gen;
  driver driv;
  monitor mon;
  scoreboard score;
  
  mailbox gen2drv;
  mailbox mon2scb;
  
  virtual fifo_if intr;
  
  function new(virtual fifo_if intr);
    this.intr = intr;
    
    gen2drv=new();
    mon2scb=new();
    gen=new(gen2drv);
    driv=new(intr,gen2drv);
    mon=new(intr,mon2scb);
    score=new(mon2scb);
    
  endfunction
  
  task main();
    fork
      gen.main();
      driv.main();
      mon.main();
      score.main();
    join
    
  endtask
endclass
    
