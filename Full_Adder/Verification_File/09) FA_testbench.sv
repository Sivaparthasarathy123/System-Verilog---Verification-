// Full Adder testbench
`include "interface.sv"
`include "test.sv"
module full_adder_tb;
  f_adder adder();
  test tst (adder);
  
  full_adder dut(.a(adder.a), .b(adder.b), .cin(adder.cin), .sum(adder.sum), .carry(adder.carry));
  
  initial begin
    $dumpfile("adder.vcd");
    $dumpvars(0, full_adder_tb);
    
  end
endmodule
   
                 
  
