// Genertor - Dual Port RAM
class generator #(parameter DEPTH = 8, WIDTH = 8);
    ram_transaction #(DEPTH, WIDTH) trans;
    mailbox gen2driv;
    event ended; 

    function new(mailbox gen2driv);
        this.gen2driv = gen2driv;
    endfunction

    task main();
        repeat(15) begin
            trans = new();
            if(!trans.randomize())
              $display("Randomization failed");
            gen2driv.put(trans);
            trans.display("--- Generator Class ---");
        end
        -> ended; 
    endtask
endclass
