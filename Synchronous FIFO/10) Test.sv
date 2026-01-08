// Synchronous FIFO Test
`include "environment.sv"

program test(fifo_if intr);
  environment env;
  
  initial begin
    env=new(intr);
    env.main();
    #10;
  end
endprogram
