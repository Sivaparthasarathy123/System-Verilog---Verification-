// D FF Generator
class generator;
  transaction trans; 
  mailbox gen2drv;
  
  function new (mailbox gen2drv);
    this.gen2drv = gen2drv;
  endfunction
  
  task main;
    
    repeat (5) begin
      trans = new();     
      
      trans.randomize();
      $display("Randomized Inputs: D = %0b", trans.d);
      
      gen2drv.put(trans);
      trans.display("Generator Class");
    end
  endtask
endclass
