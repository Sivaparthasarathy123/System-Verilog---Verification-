// Synchronous FIFO Testbench
`include "interface.sv"
`include "test.sv"

module testbench;
  bit clk;
  bit rst;

  fifo_if intr(clk, rst); 
  
  test t(intr);
  
  synchronous_FIFO inst (
    .clk(clk),
    .rst(rst),
    .w_en(intr.w_en),
    .r_en(intr.r_en),
    .data_in(intr.data_in),
    .data_out(intr.data_out),
    .full(intr.full),
    .empty(intr.empty) );
  
  initial begin
    $dumpfile("Waveform.vcd");
    $dumpvars;
    
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #10
    rst = 0; 
  end

  initial #500 $finish;
  
endmodule
