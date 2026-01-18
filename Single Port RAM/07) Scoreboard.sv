// Scoreboard - Single Port RAM
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
            if(trans.w_en) begin
                local_mem[trans.addr] = trans.data_in;
                $display("[Scoreboard] Wrote %0h to Addr %0d", trans.data_in, trans.addr);
            end 
            else begin
                if(local_mem[trans.addr] === trans.data_out)
                    $display("[Scoreboard] PASS! Read %0h from Addr %0d", trans.data_out, trans.addr);
                else
                    $display("[Scoreboard] FAIL! Expected %0h, Got %0h", local_mem[trans.addr], trans.data_out);
            end
        end
    endtask
endclass
