// Asynchronous FIFO Verification - Monitor
class monitor #(DEPTH, WIDTH);

    virtual asyn_fifo #(DEPTH, WIDTH) intr;
    mailbox mon2scb;

    function new(virtual asyn_fifo #(DEPTH, WIDTH) intr,
               mailbox mon2scb);
    this.intr = intr;
    this.mon2scb = mon2scb;
  endfunction

  task mon_main;
    transaction #(DEPTH, WIDTH) trans;
    repeat (10) begin
        trans = new();
      @(intr.wr_cb); 
    
        trans.w_rst   = intr.w_rst;
        trans.w_en    = intr.w_en; 
        trans.data_in = intr.data_in;
        trans.full    = intr.full;
    
        mon2scb.put(trans);
        trans.display(" Value to Monitor ");
      end
    
    repeat (10) begin
       trans = new();
      @(intr.rd_cb);
       
       trans.r_rst    = intr.r_rst;
       trans.r_en     = intr.r_en; 
       trans.data_out = intr.data_out;
       trans.empty    = intr.rd_cb.empty;
       
       mon2scb.put(trans);
       trans.display(" Value to Monitor ");
     end
  endtask
endclass

