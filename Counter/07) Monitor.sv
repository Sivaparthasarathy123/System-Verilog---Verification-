// Counter Monitor
class monitor;
  virtual count cnt;
  mailbox mon2scb;
  
  function new (virtual count cnt, mailbox mon2scb);
    this.cnt = cnt;
    this.mon2scb = mon2scb;
  endfunction
  
  task main;
    transaction trans;
    
    repeat (5) begin
      trans = new();
      @(posedge cnt.clk);
      trans.rst = cnt.rst;
      trans.en = cnt.en;
      trans.q = cnt.q;
      
      mon2scb.put(trans);

      trans.display("Monitor Class");
    end
  endtask
endclass
      
