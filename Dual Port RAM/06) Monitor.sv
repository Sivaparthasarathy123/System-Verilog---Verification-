// Monitor - Dual Port RAM
class monitor #(DEPTH, WIDTH);
    virtual ram_if #(DEPTH, WIDTH)vif;
    mailbox mon2scb;

    function new(virtual ram_if #(DEPTH, WIDTH) vif, mailbox mon2scb);
        this.vif = vif;
        this.mon2scb = mon2scb;
    endfunction

    task main();
        repeat (15) begin
            ram_transaction trans = new();
            @(vif.cb2); 
            trans.w_en_a     = vif.w_en_a;
            trans.addr_a     = vif.addr_a;
            trans.data_in_a  = vif.data_in_a;
            trans.data_out_a = vif.data_out_a;
            trans.w_en_b     = vif.w_en_b;
            trans.addr_b     = vif.addr_b;
            trans.data_in_b  = vif.data_in_b;
            trans.data_out_b = vif.data_out_b;
            mon2scb.put(trans);
          trans.display("--- Monitor Class---");
        end
    endtask
endclass
