// Genertor - Single Port RAM
class generator #(DEPTH, WIDTH);
    ram_transaction #(DEPTH, WIDTH) trans;
    mailbox gen2driv;
    event ended; 

    function new(mailbox gen2driv);
        this.gen2driv = gen2driv;
    endfunction

    task main();
        repeat(15) begin
            trans = new();
          trans.randomize() with {w_en == 1;};
            gen2driv.put(trans);
          trans.display("\n--- Generator Class ---");
          @ended;
        end
         
    endtask
endclass
