// Synchronous FIFO Driver
class driver;
  virtual fifo_if intr;
  mailbox gen2drv;
  
  function new (virtual fifo_if intr, mailbox gen2drv);
    this.intr = intr;
    this.gen2drv = gen2drv;
  endfunction
  
  task main;
    transaction trans;
    
    repeat (5) begin
      gen2drv.get(trans);
      @(intr.cb); 
     
      intr.cb.w_en    <= trans.w_en;
      intr.cb.r_en    <= trans.r_en;
      intr.cb.data_in <= trans.data_in;
      
      trans.display("Driver Class");
    end
  endtask
endclass
