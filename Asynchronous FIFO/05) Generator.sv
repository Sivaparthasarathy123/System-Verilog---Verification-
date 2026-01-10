// Asynchronous FIFO Verification - Generator 
class generator #(DEPTH, WIDTH);
  transaction #(DEPTH, WIDTH) trans;
  mailbox gen2drv;
  
  function new (mailbox gen2drv);
    this.gen2drv = gen2drv;
  endfunction
  
  task gen_main;
    
    repeat (10) begin
     
      trans = new();
      if (trans.randomize() with {trans.w_en == 1; w_rst == 0; r_rst == 0;})
        $display("Time = %0t | Randomized Inputs: w_rst = %d | w_en = %0d", $time, trans.w_rst, trans.w_en);
       else
          $display("Transaction Values NOT Randomized");
      
       gen2drv.put(trans);
       trans.display (" Generator class for Write Operation ");
      
    end
    
    repeat (10) begin
      
       trans = new();
      if (trans.randomize() with {trans.r_en == 1; w_rst == 0; r_rst == 0; data_in == 0;})
        $display("Time = %0t | Randomized Inputs: r_rst = %d | r_en = %0d", $time, trans.r_rst, trans.r_en);
       else
          $display("Transaction Values NOT Randomized");
       gen2drv.put(trans);
       trans.display (" Generator class for Read Operation ");
        
    end
  endtask
endclass
      
      
      
