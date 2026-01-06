// Counter Scoreboard
class scoreboard;
  mailbox mon2scb;
  bit[2:0]exp_q;

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
    exp_q = 0;
  endfunction
  
  task main;
    transaction trans;
    
    repeat (5) begin
      mon2scb.get(trans);
      
      if (trans.rst)
        exp_q = 0;
      else if (trans.en)
        exp_q = exp_q + 1;
      else if (!trans.en) begin
        exp_q = 7;
        exp_q = exp_q - 1;
      end
    
    if (exp_q == trans.q)
      $display("PASS: Expected Output Q = %0d| Output Q = %0d", exp_q, trans.q);
    else
      $display("FAIL: Expected Output Q = %0d| Output Q = %0d", exp_q, trans.q);
      
    end
  endtask
endclass
    
    
  
