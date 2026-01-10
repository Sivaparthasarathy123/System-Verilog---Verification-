// Asynchronous FIFO Verification - Driver
class driver #(DEPTH, WIDTH);

  virtual asyn_fifo #(DEPTH, WIDTH) intr;
  mailbox gen2drv;

  function new(virtual asyn_fifo #(DEPTH, WIDTH) intr,
               mailbox gen2drv);
    this.intr = intr;
    this.gen2drv = gen2drv;
  endfunction
  
  task drv_main;
    transaction #(DEPTH, WIDTH) trans;
    repeat (10) begin
        gen2drv.get(trans);
        if (trans.w_en) begin
            @(intr.wr_cb);
            intr.wr_cb.w_rst   <= trans.w_rst;
            intr.wr_cb.w_en    <= trans.w_en;
            intr.wr_cb.data_in <= trans.data_in;
        end
      trans.display(" Write Value to Driver ");
    end
    repeat (10) begin
      gen2drv.get(trans);
        if (trans.r_en) begin
            @(intr.rd_cb);
            intr.rd_cb.r_rst <= trans.r_rst;
            intr.rd_cb.r_en  <= trans.r_en; 
            intr.data_out  <= trans.data_out;
          
        end
      trans.display("  Read Value to Driver ");
    end
  endtask

endclass
