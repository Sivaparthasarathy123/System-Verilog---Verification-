// Driver - Single Port RAM
class driver #(DEPTH, WIDTH);
    virtual ram_if #(DEPTH, WIDTH) vif;
    mailbox gen2driv;

    function new(virtual ram_if #(DEPTH, WIDTH) vif, mailbox gen2driv);
        this.vif = vif;
        this.gen2driv = gen2driv;
    endfunction

    task main();
        repeat (15) begin
            ram_transaction trans;
            gen2driv.get(trans);
            @(vif.cb1);
            vif.cb1.w_en    <= trans.w_en;
            vif.cb1.addr    <= trans.addr;
            vif.cb1.data_in <= trans.data_in;
            trans.display("--- Driver Class ---");
        end
    endtask
endclass
