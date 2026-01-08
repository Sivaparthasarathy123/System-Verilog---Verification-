// Synchronous FIFO Testbench
`include "interface.sv"
`include "test.sv"

module testbench;
  bit clk;
  bit rst;
  
  parameter DEPTH = 8;
  parameter WIDTH = 8;

  fifo_if #(DEPTH, WIDTH) intr(clk, rst); 
  
  test #(DEPTH, WIDTH) t(intr);
  
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

  initial #1000 $finish;
  
endmodule
