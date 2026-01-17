// Interface - Single Port RAM
interface ram_if(input logic clk);
    logic w_en;
    logic [2:0] addr;     
    logic [7:0] data_in;  
    logic [7:0] data_out;
endinterface
