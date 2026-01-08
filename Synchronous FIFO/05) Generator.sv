// Synchronous FIFO Generator
class generator #(DEPTH, WIDTH);
  transaction #(DEPTH, WIDTH) trans;
  
  mailbox gen2drv;
  
  function new (mailbox gen2drv);
    this.gen2drv = gen2drv;
  endfunction
  
  task main;
    $display(" Generator Class ");
    // --- Write Untill Full ---
    repeat (3) begin
      trans = new();
      trans.randomize() with {w_en == 1; r_en == 0;};
       $display("[%0t] Randomized Inputs: Write Enable = %0d| Read Enable = %0d| Data In = %0d", $time, trans.w_en, trans.r_en, trans.data_in);
      gen2drv.put(trans);
    end

    // --- Read until Empty ---
    repeat (3) begin
      trans = new();
      trans.randomize() with {w_en == 0; r_en == 1;};
       $display("[%0t] Randomized Inputs: Write Enable = %0d| Read Enable = %0d| Data In = %0d", $time, trans.w_en, trans.r_en, trans.data_in);
      gen2drv.put(trans);
    end

    // --- Read and Write ---
    repeat (3) begin
      trans = new();
      trans.randomize() with {w_en == 1; r_en == 1;};
       $display("[%0t] Randomized Inputs: Write Enable = %0d| Read Enable = %0d| Data In = %0d", $time, trans.w_en, trans.r_en, trans.data_in);
      gen2drv.put(trans);
   end
  endtask
endclass
