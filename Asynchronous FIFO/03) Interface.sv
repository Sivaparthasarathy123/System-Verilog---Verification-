// Asynchronous FIFO Verification - Interface
interface asyn_fifo #(parameter DEPTH = 8, WIDTH = 8);
    logic w_clk, r_clk;
    logic w_rst, r_rst;
    logic w_en, r_en;
    logic [WIDTH-1:0] data_in;
    logic [WIDTH-1:0] data_out;
    logic full, empty;
    
    // Write the data for driver
  clocking wr_cb @(negedge w_clk);
        default input #1ns output #1ns;
        output w_rst, w_en, data_in; 
        input  full;                 
    endclocking
    
    // Read the data for driver
  clocking rd_cb @(negedge r_clk);
        default input #1ns output #1ns;
        output r_rst, r_en;
        input  data_out, empty;      
    endclocking
  
  // Write the data for monitor
  clocking wr_cb1 @(posedge w_clk);
        default input #1ns;
        input  full,w_rst, w_en, data_in;                 
    endclocking
    
    // Read the data for monitor
  clocking rd_cb1 @(posedge r_clk);
        default input #1ns; 
        input  data_out, empty, r_rst, r_en;     
    endclocking
  
endinterface
