// Asynchronous FIFO Verification - Generator 
class generator #(DEPTH, WIDTH);
  transaction #(DEPTH, WIDTH) wr_trans;
  transaction #(DEPTH, WIDTH) rd_trans;
  mailbox gen2drv_wr;
  mailbox gen2drv_rd;
  event wr_ended;
  event rd_ended;

  int write_count = 0;
  int read_count = 0;

  function new(mailbox gen2drv_wr, mailbox gen2drv_rd, event wr_ended, rd_ended);
    this.gen2drv_wr = gen2drv_wr;
    this.gen2drv_rd = gen2drv_rd;
    this.wr_ended = wr_ended;
    this.rd_ended = rd_ended;
  endfunction

  task gen_main;
    fork
      write;
      read;
    join
  endtask

  task write;
    $display("---------- WRITE ONLY STARTED ------------");

    for(int i = 0; i < DEPTH; i++) begin
      wr_trans = new(); 
      wr_trans.randomize with {w_en == 1; r_en == 0; w_rst == 0; r_rst == 0;};
      gen2drv_wr.put(wr_trans);
      write_count++;
      wr_trans.display("Write Generator class");
    end
    $display("Generator -> Created -> [%0d] write transactions", write_count);
    @wr_ended;
  endtask

  task read;
    $display("---------- READ ONLY STARTED ------------");

    for(int i = 0; i < DEPTH; i++) begin
      rd_trans = new();
      rd_trans.randomize with {r_en == 1; w_en == 0; w_rst == 0; r_rst == 0; data_in == 0;};
      gen2drv_rd.put(rd_trans);
      read_count++;
      rd_trans.display("Read Generator class");
    end
    $display("Generator -> Created -> [%0d] read transactions", read_count);
    @rd_ended;
  endtask

  task write_read;
    $display("---------- WRITE & READ STARTED ------------");       // NOT CALLED

    for(int i = 0; i < DEPTH; i++) begin
      fork
        // Write transaction
        begin
          wr_trans = new();
          wr_trans.randomize with {w_en == 1; r_en == 0; w_rst == 0; r_rst == 0;};
          gen2drv_wr.put(wr_trans);
          write_count++;
        end

        // Read transaction  
        begin
          rd_trans = new();
          rd_trans.randomize with {r_en == 1; w_en == 0; w_rst == 0; r_rst == 0;};
          gen2drv_rd.put(rd_trans);
          read_count++;
        end
      join

    end
  endtask
endclass
