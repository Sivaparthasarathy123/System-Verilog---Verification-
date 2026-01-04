`include "interface.sv"
`include "test.sv"

module testbench;
  intr_dff intr();
  test t(intr);
  
  d_ff inst(intr.dut_mp);
  
  initial begin
    $dumpfile("Waveform.vcd");
    $dumpvars;
    
    intr.clk=0;
    forever #5 intr.clk=~intr.clk;
    
    intr.rst=1;
    #5 intr.rst=0;
    
    $display("CLK = %0b",intr.clk);
    
  end
  initial 
   
    #100 $finish;
  
endmodule
