// Synchronous FIFO Interface
interface fifo_if #(parameter DEPTH = 8, WIDTH = 8) 
  (input logic clk, 
   input logic rst);
  
  logic w_en, r_en;
  logic [WIDTH-1:0] data_in;
  logic [WIDTH-1:0] data_out;
  logic full, empty;

  // Clocking Block 
  clocking cb @(posedge clk);
    default input #1ns output #1ns;
  
    output data_in;
    output w_en;
    output r_en;
  
    input  data_out;
    input  full;
    input  empty;
  endclocking

  // Modport for Testbench 
  modport tb (clocking cb, input clk, rst);
  // Modport for DUT  
  modport dut (input clk, rst, w_en, r_en, data_in,
               output data_out, full, empty);

endinterface
