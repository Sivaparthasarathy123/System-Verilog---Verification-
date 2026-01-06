// Counter Verification Testbench
`include "interface.sv"
`include "test.sv"

module testbench;
  count cnt();
  test t(cnt);
  
  counter inst(.clk(cnt.clk), 
               .rst(cnt.rst) ,
               .en(cnt.en) ,
               .q(cnt.q));
  
  initial begin
    $dumpfile("Waveform.vcd");
    $dumpvars;
  end
  
  initial begin
    cnt.clk = 0;
    forever #5 cnt.clk = ~cnt.clk;
  end

  initial begin
    cnt.rst = 1;
    #12 cnt.rst = 0;
  end
    
  initial 
   
    #100 $finish;
  
endmodule
