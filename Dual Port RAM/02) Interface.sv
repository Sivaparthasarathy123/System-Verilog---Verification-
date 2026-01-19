// Interface - Single Port RAM
interface ram_if #(parameter DEPTH = 8, WIDTH = 8) (input logic clk);
    logic w_en_a, w_en_b;
    logic [$clog2(DEPTH)-1:0] addr_a, addr_b;     
    logic [WIDTH-1:0] data_in_a, data_in_b;  
    logic [WIDTH-1:0] data_out_a, data_out_b;
endinterface
