// Driver - Dual Port RAM
class driver #(DEPTH, WIDTH);
    virtual ram_if #(DEPTH, WIDTH) vif;
    mailbox gen2driv;

    function new(virtual ram_if #(DEPTH, WIDTH) vif, mailbox gen2driv);
        this.vif = vif;
        this.gen2driv = gen2driv;
    endfunction

    task main();
      // PORT A and PORT B
        repeat (15) begin
            ram_transaction trans;
            gen2driv.get(trans);
            @(vif.cb1);
            vif.cb1.w_en_a    <= trans.w_en_a;
            vif.cb1.addr_a    <= trans.addr_a;
            vif.cb1.data_in_a <= trans.data_in_a;
            vif.cb1.w_en_b    <= trans.w_en_b;
            vif.cb1.addr_b    <= trans.addr_b;
            vif.cb1.data_in_b <= trans.data_in_b;
            trans.display("--- Driver Class ---");
     
        end
    endtask
endclass
