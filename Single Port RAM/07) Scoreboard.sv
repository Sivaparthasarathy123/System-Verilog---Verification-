// Scoreboard - Single Port RAM
class scoreboard #(DEPTH, WIDTH);
    mailbox mon2scb;
  bit [WIDTH-1:0] local_mem [DEPTH];
  bit [WIDTH-1:0] expected;

    function new(mailbox mon2scb);
        this.mon2scb = mon2scb;
    endfunction

    event ended;

  task main();
    ram_transaction trans;
  repeat (15) begin
        mon2scb.get(trans);

        // First capture expected OLD value
        expected = local_mem[trans.addr];

        // Then update RAM if write
        if(trans.w_en) begin
            local_mem[trans.addr] = trans.data_in;
            $display("[Scoreboard] Write %0h to Addr %0d", trans.data_in, trans.addr);
        end

        // comparing
        if(expected === trans.data_out)
            $display("[Scoreboard] PASS! Read %0h from Addr %0d", trans.data_out, trans.addr);
        else
            $display("[Scoreboard] FAIL! Expected %0h, Got %0h", expected, trans.data_out);
         trans.display("---Scoreboard Class---\n");
        ->ended;
    end
  endtask

endclass
