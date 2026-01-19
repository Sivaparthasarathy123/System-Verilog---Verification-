// Driver - Dual Port RAM
class driver #(DEPTH, WIDTH);
    virtual ram_if #(DEPTH, WIDTH) vif;
    mailbox gen2driv;

    function new(virtual ram_if #(DEPTH, WIDTH) vif, mailbox gen2driv);
        this.vif = vif;
        this.gen2driv = gen2driv;
    endfunction

    task main();
      // PORT A
        repeat (5) begin
            ram_transaction trans;
            gen2driv.get(trans);
            @(posedge vif.clk);
            vif.w_en_a    <= trans.w_en_a;
            vif.addr_a    <= trans.addr_a;
            vif.data_in_a <= trans.data_in_a;
            trans.display("--- Driver Class ---");
          $display("[Driver] Applied Addr A: %0d", trans.addr_a);
        end
      
      // PORT B
       repeat (5) begin
            ram_transaction trans;
            gen2driv.get(trans);
            @(posedge vif.clk);
            vif.w_en_b    <= trans.w_en_b;
            vif.addr_b    <= trans.addr_b;
            vif.data_in_b <= trans.data_in_b;
            trans.display("--- Driver Class ---");
         $display("[Driver] Applied Addr A: %0d", trans.addr_b);
        end
    endtask
endclass
