// D FF Driver
class driver;
  virtual intr_dff intr;
  mailbox gen2drv;
  
  function new (virtual intr_dff intr, mailbox gen2drv);
    this.intr = intr;
    this.gen2drv = gen2drv;
  endfunction
  
  task main;
    transaction trans;
    
    repeat (5) begin
      gen2drv.get(trans);
      @(posedge intr.clk);
      
      intr.rst <= trans.rst;
      intr.d <= trans.d;
      trans.display("Driver Class");
    end
  endtask
endclass
      
