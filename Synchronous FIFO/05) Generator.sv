// Synchronous FIFO Generator
class generator;
  transaction trans;
  
  mailbox gen2drv;
  
  function new (mailbox gen2drv);
    this.gen2drv = gen2drv;
  endfunction
  
  task main;
    transaction trans;
    
    repeat (5) begin
      trans = new();
      trans.randomize();
      $display("[%0t] Randomized Inputs: Data In = %0d", $time, trans.data_in);
      
      gen2drv.put(trans);
      trans.display("Generator Class");
    end
  endtask
endclass
