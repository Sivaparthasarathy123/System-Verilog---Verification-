// Scoreboard - Dual Port RAM
class scoreboard #(DEPTH, WIDTH);
    mailbox mon2scb;
    bit [7:0] local_mem [8]; 

    function new(mailbox mon2scb);
        this.mon2scb = mon2scb;
    endfunction

    task main();
        ram_transaction trans;
        forever begin
            mon2scb.get(trans);
          if(trans.w_en_a) begin
            local_mem[trans.addr_a] = trans.data_in_a;
            $display("[Scoreboard] Wrote %0h to Addr A %0d", trans.data_in_a, trans.addr_a);
            end else begin
              if(local_mem[trans.addr_a] === trans.data_out_a)
                $display("[Scoreboard] PASS! Read %0h from Addr A %0d", trans.data_out_a, trans.addr_a);
                else
                  $display("[Scoreboard] FAIL! Expected %0h, Got %0h", local_mem[trans.addr_a], trans.data_out_a);
            end
        end

       forever begin
            mon2scb.get(trans);
         if(trans.w_en_b) begin
           local_mem[trans.addr_b] = trans.data_in_b;
           $display("[Scoreboard] Wrote %0h to Addr B %0d", trans.data_in_b, trans.addr_b);
            end else begin
              if(local_mem[trans.addr_b] === trans.data_out_b)
                $display("[Scoreboard] PASS! Read %0h from Addr B %0d", trans.data_out_b, trans.addr_b);
                else
                  $display("[Scoreboard] FAIL! Expected %0h, Got %0h", local_mem[trans.addr_b], trans.data_out_b);
            end
        end
    endtask
endclass
