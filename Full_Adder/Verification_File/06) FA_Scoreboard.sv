// Scoreboard Block
class scoreboard;
  mailbox montoscb;
  
  function new (mailbox montoscb);
    this.montoscb = montoscb;
  endfunction
  
  task main;
   transaction trans;
    
    repeat (3) begin
    
    montoscb.get(trans); //Getting the values from monitor to scoreboard
    
      if( ((trans.a^trans.b^trans.cin) == trans.sum) &&
    (((trans.a & trans.b) | (trans.b & trans.cin) | (trans.a & trans.cin)) == trans.carry) )
        $display("Passed value: a=%0d b=%0d cin=%0d sum=%0d carry=%0d", trans.a, trans.b, trans.cin, trans.sum, trans.carry);

      else
        $display("Fail value");
    end
    
  endtask
endclass

    
    
