// Environment - Single Port RAM
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment #(DEPTH, WIDTH);
    // Instantiate components
    generator  #(DEPTH, WIDTH) gen;
    driver     #(DEPTH, WIDTH) driv;
    monitor    #(DEPTH, WIDTH) mon;
    scoreboard #(DEPTH, WIDTH) scb;

    // Mailboxes 
    mailbox gen2driv;
    mailbox mon2scb;

    virtual ram_if #(DEPTH, WIDTH) vif;

    function new(virtual ram_if #(DEPTH, WIDTH) vif);
        this.vif = vif;
        gen2driv = new();
        mon2scb  = new();
        
        gen  = new(gen2driv);
        driv = new(vif, gen2driv);
        mon  = new(vif, mon2scb);
        scb  = new(mon2scb);
    endfunction

    task run();
        fork
            gen.main();
            driv.main();
            mon.main();
            scb.main();
        join
    endtask
endclass
