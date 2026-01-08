// Synchronous FIFO Driver
class driver #(DEPTH, WIDTH);
  virtual fifo_if #(DEPTH, WIDTH) intr;
  mailbox gen2drv;
  
  function new (virtual fifo_if #(DEPTH, WIDTH) intr, mailbox gen2drv);
    this.intr = intr;
    this.gen2drv = gen2drv;
  endfunction
  
  task main;
    transaction #(DEPTH, WIDTH) trans;
    
    repeat (9) begin
      gen2drv.get(trans);
      @(intr.cb); 
           
      intr.cb.w_en    <= trans.w_en;
      intr.cb.r_en    <= trans.r_en;
      intr.cb.data_in <= trans.data_in;
      
      trans.display("Driver Class");
    end
  endtask
endclass
