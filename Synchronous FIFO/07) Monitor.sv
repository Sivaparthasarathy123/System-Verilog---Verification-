// Synchronous FIFO Monitor
class monitor;
  virtual fifo_if intr;
  mailbox mon2scb;
  
  function new (virtual fifo_if intr, mailbox mon2scb);
    this.intr = intr;
    this.mon2scb = mon2scb;
  endfunction
  
  task main;
    transaction trans;
    repeat (5) begin
      trans = new();
       @(intr.cb); 
    
      trans.w_en     = intr.w_en;
      trans.r_en     = intr.r_en;
      trans.data_in  = intr.data_in;
    
      trans.data_out = intr.cb.data_out;
      trans.full     = intr.cb.full;
      trans.empty    = intr.cb.empty;
    
      mon2scb.put(trans);
      trans.display(" Monitor Class ");
    end
  endtask
endclass

      
      
