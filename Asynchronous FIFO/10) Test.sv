// Asynchronous FIFO Verification - Test
`include "environment.sv"

program test #(DEPTH, WIDTH ) (asyn_fifo intr); 
  environment #(DEPTH, WIDTH) env;
  
  initial begin
    env = new(intr);
    env.run_main();
    #10;
  end
endprogram
