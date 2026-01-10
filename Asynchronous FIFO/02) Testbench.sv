// Asynchronous FIFO Verification - Testbench
`timescale 1ns/1ps
`include "interface.sv"
`include "test.sv"

module asynchronous_fifo_tb();
  parameter DEPTH = 8;
  parameter WIDTH = 8;

  asyn_fifo #(DEPTH, WIDTH) intr();
  test #(DEPTH, WIDTH) t1(intr);

  Asynchronous_fifo #(DEPTH, WIDTH) inst (
    .w_clk(intr.w_clk),
    .r_clk(intr.r_clk),
    .w_rst(intr.w_rst),
    .r_rst(intr.r_rst),
    .w_en(intr.w_en),
    .r_en(intr.r_en),
    .data_in(intr.data_in),
    .data_out(intr.data_out),
    .full(intr.full),
    .empty(intr.empty));

  // Clock Generation
  initial begin
    intr.w_clk = 0;
    intr.r_clk = 0;
  end
  always #5 intr.w_clk = ~intr.w_clk;
  always #5 intr.r_clk = ~intr.r_clk;


  initial begin
    intr.w_rst = 1; 
    intr.r_rst = 1;
    intr.w_en = 0;
    intr.r_en = 0;
    #20 intr.w_rst = 0; intr.r_rst = 0;
    
    $dumpfile("Asynchronous FIFO.vcd");
    $dumpvars(0,asynchronous_fifo_tb);
    #1000;
    $finish;
  end

endmodule
