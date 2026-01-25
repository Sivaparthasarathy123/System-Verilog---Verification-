// Test - Dual Port RAM
`include "environment.sv"
program test #(DEPTH, WIDTH)(ram_if vif);
  environment #(DEPTH, WIDTH) env;

    initial begin
        env = new(vif);
        env.run();
        #20; 
        $display("--- Final Verification Success ---");
        $finish;
    end
endprogram
