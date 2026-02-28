// Asynchronous FIFO Verification - Driver
class driver #(DEPTH, WIDTH);
  virtual asyn_fifo #(DEPTH, WIDTH) intr;
  mailbox gen2drv;

  function new(virtual asyn_fifo #(DEPTH, WIDTH) intr, mailbox gen2drv);
    this.intr = intr;
    this.gen2drv = gen2drv;
  endfunction

  task drv_main;
    transaction #(DEPTH, WIDTH) trans;
    forever begin
      gen2drv.get(trans);

      // WRITE side
        @(intr.wr_cb);
          intr.wr_cb.w_rst   <= trans.w_rst;
          intr.wr_cb.w_en    <= trans.w_en;
          intr.wr_cb.data_in <= trans.data_in;
     
      // READ side
        @(intr.rd_cb);
          intr.rd_cb.r_rst <= trans.r_rst;
          intr.rd_cb.r_en  <= trans.r_en;
          trans.display("Driver Class ");
       
    end
      
  endtask
endclass
