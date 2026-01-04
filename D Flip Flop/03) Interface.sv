// D_FF interface
interface intr_dff;
  logic clk;
  logic rst;
  logic d;
  logic q;
  
  modport dut_mp (input clk, rst, d, output q); 
  modport tb_mp  (output clk, rst, d, input q); 
  
endinterface
