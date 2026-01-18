// Driver - Single Port RAM
class driver #(DEPTH, WIDTH);
    virtual ram_if #(DEPTH, WIDTH) vif;
    mailbox gen2driv;

    function new(virtual ram_if #(DEPTH, WIDTH) vif, mailbox gen2driv);
        this.vif = vif;
        this.gen2driv = gen2driv;
    endfunction

    task main();
        forever begin
            ram_transaction trans;
            gen2driv.get(trans);
            @(posedge vif.clk);
            vif.w_en    <= trans.w_en;
            vif.addr    <= trans.addr;
            vif.data_in <= trans.data_in;
            trans.display("--- Driver Class ---");
            $display("[Driver] Applied Addr: %0d", trans.addr);
        end
    endtask
endclass
