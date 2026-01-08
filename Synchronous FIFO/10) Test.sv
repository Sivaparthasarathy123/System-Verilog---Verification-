// Synchronous FIFO Test
`include "environment.sv"

program test #(DEPTH, WIDTH) (fifo_if intr);
  environment #(DEPTH, WIDTH) env;
  
  initial begin
    env=new(intr);
    env.main();
  end
endprogram
