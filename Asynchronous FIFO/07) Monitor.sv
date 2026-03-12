// Asynchronous FIFO Verification - Monitor
class monitor #(DEPTH, WIDTH);
  virtual asyn_fifo #(DEPTH, WIDTH) intr;
  mailbox mon2scb_wr;
  mailbox mon2scb_rd;

  function new(virtual asyn_fifo #(DEPTH, WIDTH) intr, mailbox mon2scb_wr, mailbox mon2scb_rd);
    this.intr = intr;
    this.mon2scb_wr = mon2scb_wr;
    this.mon2scb_rd = mon2scb_rd;
  endfunction

  task mon_main;
    fork
      write_monitor;
      read_monitor;
    join
  endtask

  task write_monitor;
    transaction #(DEPTH, WIDTH) wr_trans;
    forever begin
      @(intr.wr_mon);

      if(intr.w_rst) begin
        wr_trans = new();
        wr_trans.w_rst = 1;
        wr_trans.w_en = 0;
        wr_trans.data_in = 0;
        wr_trans.full = intr.full;
        mon2scb_wr.put(wr_trans);
      end
      else if(intr.w_en) begin
        wr_trans = new();
        wr_trans.w_rst = 0;
        wr_trans.w_en = 1;
        wr_trans.data_in = intr.data_in;
        wr_trans.full = intr.full;
        $display(" ---- Monitor Write at %0t -> data = %0d", $time, intr.data_in);
        mon2scb_wr.put(wr_trans);
      end
    end
  endtask

  task read_monitor;
    transaction #(DEPTH, WIDTH) rd_trans;
    forever begin
      @(intr.rd_mon);

      if(intr.r_rst) begin
        rd_trans = new();
        rd_trans.r_rst = 1;
        rd_trans.r_en = 0;
        rd_trans.data_out = intr.data_out;
        rd_trans.empty = intr.empty;
        mon2scb_rd.put(rd_trans);
      end
      else if(intr.r_en) begin
        rd_trans = new();
        rd_trans.r_rst = 0;
        rd_trans.r_en = 1;
        rd_trans.data_out = intr.data_out;
        rd_trans.empty = intr.empty;
        $display(" ---- Monitor Read at %0t -> data = %0d", $time, intr.data_out);
        mon2scb_rd.put(rd_trans);
      end
    end
  endtask
endclass
