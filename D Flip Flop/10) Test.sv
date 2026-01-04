`include "environment.sv"

program test(intr_dff intr);
  environment env;
  
  initial begin
    env=new(intr);
    env.main();
    #10;
  end
endprogram
