// D FF Monitor
class monitor;
  virtual intr_dff intr;
  mailbox mon2scb;
  
  function new (virtual intr_dff intr, mailbox mon2scb);
    this.intr = intr;
    this.mon2scb = mon2scb;
  endfunction
  
  task main;
    transaction trans;
    
    repeat (5) begin
      trans = new();
      @(posedge intr.clk);
      
      trans.rst = intr.rst;
      trans.d = intr.d;
      trans.q = intr.q;
      
      mon2scb.put(trans);
      trans.display("Monitor Class");
      #5;
    end
  endtask
endclass
