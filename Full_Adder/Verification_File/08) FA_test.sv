// Test block
`include "environment.sv"
program test(f_adder adder);
  environment env;

  initial begin
    env = new(adder);
    env.final_test();
  end
endprogram
