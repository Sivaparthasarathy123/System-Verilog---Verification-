// Dual port RAM
module dual_port_ram #(parameter DEPTH = 8, WIDTH = 8)(
    input clk,
    input w_en_a, w_en_b,
    input [$clog2(DEPTH)-1:0] addr_a, addr_b,
    input [WIDTH-1:0] data_in_a, data_in_b,
    output reg [WIDTH-1:0] data_out_a, data_out_b);

  reg [WIDTH-1:0] mem [0:DEPTH-1];

  always @(posedge clk) begin
    // PORT A
    if(w_en_a)
        mem[addr_a] <= data_in_a;
    data_out_a <= mem[addr_a];

    // PORT B
    if(w_en_b)
        mem[addr_b] <= data_in_b;
    data_out_b <= mem[addr_b]; 
  end

endmodule
