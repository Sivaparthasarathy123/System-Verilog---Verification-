// Counter Test
`include "environment.sv"

program test(count cnt);
  environment env;
  
  initial begin
    env=new(cnt);
    env.main();
    #10;
  end
endprogram
