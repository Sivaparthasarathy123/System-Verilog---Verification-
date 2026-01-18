// Testbench - Single Port RAM
`include "interface.sv"
`include "test.sv"
module Sram_tb;
    localparam DEPTH = 8;
    localparam WIDTH = 8;

    bit clk;
    always #5 clk = ~clk;

    // Interface Instance
    ram_if #(DEPTH, WIDTH) vif(clk);
  
    // TestInstance
    test #(DEPTH, WIDTH) t1(vif);

    // DUT Instance
    single_port_RAM #(DEPTH, WIDTH) dut (
      .clk(vif.clk),
      .w_en(vif.w_en),
      .addr(vif.addr),
      .data_in(vif.data_in),
      .data_out(vif.data_out)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule
