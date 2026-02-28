// Asynchronous FIFO Verification - Generator 
class generator #(DEPTH, WIDTH);
  transaction #(DEPTH, WIDTH) trans;
  mailbox gen2drv;
  event ended;

  function new(mailbox gen2drv, event ended);
    this.gen2drv = gen2drv;
    this.ended = ended;
  endfunction
  
  task gen_main;
  repeat (15) begin 
    // Perform Writes
    for(int i = 0; i < DEPTH + 2; i++) begin
      trans = new(); 
      trans.randomize with {w_en == 1; r_en == 0; w_rst == 0; r_rst == 0;};
      gen2drv.put(trans); 
    end
    
    // Perform Reads
    for(int i = 0; i < DEPTH; i++) begin
      trans = new();
      trans.randomize with {r_en == 1; w_en == 0; w_rst == 0; r_rst == 0;};
      gen2drv.put(trans);
    end
    
    for(int i = 0; i < DEPTH + 2; i++) begin
      trans = new(); 
      trans.randomize with {w_en == 1; r_en == 1; w_rst == 0; r_rst == 0;};
      gen2drv.put(trans); 
    end
    trans.display("Generator class");
    @ended; 
  end
endtask
endclass
