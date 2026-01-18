// Interface - Single Port RAM
interface ram_if #(parameter DEPTH = 8, WIDTH = 8) (input logic clk);
    logic w_en;
    logic [$clog2(DEPTH)-1:0] addr;     
    logic [WIDTH-1:0] data_in;  
    logic [WIDTH-1:0] data_out;
endinterface
