// D FF Scoreboard
class scoreboard;
  mailbox mon2scb;
  bit exp_q;
  bit prev_d;
  
  function new (mailbox mon2scb);
    this.mon2scb = mon2scb;
    prev_d = 0;
  endfunction
  
  task main;
    transaction trans;
    
    repeat (5) begin
      mon2scb.get(trans);
      if (trans.rst)
        exp_q = 0;
      else
        exp_q = prev_d;
      
      if (exp_q == trans.q)
        $display("PASS");
      else
        $display("FAIL");
      
      prev_d = trans.d;
      trans.display("Scoreboard Class");
    end
  endtask
endclass
      
      
