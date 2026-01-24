// Interface - Single Port RAM
interface ram_if #(parameter DEPTH = 8, WIDTH = 8) (input logic clk);
    logic w_en;
    logic [$clog2(DEPTH)-1:0] addr;     
    logic [WIDTH-1:0] data_in;  
    logic [WIDTH-1:0] data_out;
  
  clocking cb1 @(negedge clk);
    default input #1step output #1step;
     output w_en, addr, data_in;
     input data_out;
  endclocking
  
  clocking cb2 @(posedge clk);
    default input #1step output #1step;
     input w_en, addr, data_in, data_out;
  endclocking
  
endinterface
