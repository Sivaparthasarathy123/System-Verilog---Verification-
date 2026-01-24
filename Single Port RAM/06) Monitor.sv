// Monitor - Single Port RAM
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
            trans.w_en     = vif.w_en;
            trans.addr     = vif.addr;
            trans.data_in  = vif.data_in;
            trans.data_out = vif.data_out;
            mon2scb.put(trans);
            trans.display("--- Monitor Class ---");
        end
    endtask
endclass
