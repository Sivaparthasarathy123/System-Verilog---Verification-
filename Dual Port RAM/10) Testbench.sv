// Testbench - Dual Port RAM
`include "interface.sv"
`include "test.sv"
module Dram_tb;
    localparam DEPTH = 8;
    localparam WIDTH = 8;

    bit clk;
    always #5 clk = ~clk;

    // Interface Instance
    ram_if #(DEPTH, WIDTH) vif(clk);
  
    // TestInstance
    test #(DEPTH, WIDTH) t1(vif);

    // DUT Instance
    dual_port_ram #(DEPTH, WIDTH) dut (
      .clk(vif.clk),
      .w_en_a(vif.w_en_a),
      .w_en_b(vif.w_en_b),
      .addr_a(vif.addr_a),
      .addr_b(vif.addr_b),
      .data_in_a(vif.data_in_a),
      .data_in_b(vif.data_in_b),
      .data_out_a(vif.data_out_a),
      .data_out_b(vif.data_out_b)
    );

    
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule
