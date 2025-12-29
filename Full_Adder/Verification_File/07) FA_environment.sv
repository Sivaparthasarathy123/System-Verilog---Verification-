// Environment Block
`include "transaction.sv" // include all the blocks in environment
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
  
class environment;  
  generator gen;     
  driver drv;
  monitor mon;
  scoreboard scb;
  
  mailbox gentodrv;
  mailbox montoscb;
  
  virtual f_adder add;
  
  function new (virtual f_adder add);
    this.add = add;
    
    gentodrv = new();
    montoscb = new();
    gen = new(gentodrv);
    drv = new(add, gentodrv);
    mon = new(add, montoscb);
    scb = new(montoscb);
    
  endfunction
  
  task final_test;
    fork
      gen.main;
      drv.main;
      mon.main;
      scb.main;
    join
  endtask
  
endclass

    
  
