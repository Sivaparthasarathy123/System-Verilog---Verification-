// Counter Interface
interface count;
  logic clk;
  logic rst;
  logic en;
  logic [2:0]q;
  
   modport dut_c (input clk, rst, en, output q);
   modport tb_c(input q, output clk, rst, en);
  
endinterface
