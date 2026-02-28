// Asynchronous FIFO Verification - Monitor
class monitor #(DEPTH, WIDTH);
  virtual asyn_fifo #(DEPTH, WIDTH) intr;
  mailbox mon2scb;

  function new(virtual asyn_fifo #(DEPTH, WIDTH) intr, mailbox mon2scb);
    this.intr = intr;
    this.mon2scb = mon2scb;
  endfunction

  task mon_main;
    fork
        // Monitor Write Clock Domain
        forever begin
            transaction #(DEPTH, WIDTH) w_trans = new();
            @(intr.wr_cb1);
            w_trans.w_rst   = intr.wr_cb1.w_rst;
            w_trans.w_en    = intr.wr_cb1.w_en;
            w_trans.data_in = intr.wr_cb1.data_in;
            w_trans.full    = intr.wr_cb1.full;
            
            mon2scb.put(w_trans);
        end

        // Monitor Read Clock Domain
        forever begin
            transaction #(DEPTH, WIDTH) r_trans = new();
            @(intr.rd_cb1);
            r_trans.r_rst    = intr.rd_cb1.r_rst;
            r_trans.r_en     = intr.rd_cb1.r_en;
            r_trans.data_out = intr.rd_cb1.data_out;
            r_trans.empty    = intr.rd_cb1.empty;
  
            mon2scb.put(r_trans);
        end
    join
  endtask
endclass
