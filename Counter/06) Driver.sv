// Counter Driver
class driver;
  virtual count cnt;
  mailbox gen2drv;
  
  function new ( virtual count cnt, mailbox gen2drv);
    this.cnt = cnt;
    this.gen2drv = gen2drv;
  endfunction
  
  task main;
    transaction trans;
    
    repeat (5) begin
      gen2drv.get(trans);
      
      cnt.rst <= trans.rst;
      cnt.en <= trans.en;
    
      @(posedge cnt.clk);
      trans.display("Driver Class");
    end
  endtask
endclass
