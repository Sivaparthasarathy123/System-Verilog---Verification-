// Counter Generator
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
      $display("Randomized Inputs: Reset = %0b| Enable = %0b", trans.rst, trans.en);
      trans.display("Generator Class");
      gen2drv.put(trans);
      #5;
    end
  endtask
endclass
