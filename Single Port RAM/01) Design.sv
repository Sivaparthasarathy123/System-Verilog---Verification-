//Single port RAM
module single_port_RAM #(
    parameter DEPTH = 8, 
    parameter WIDTH = 8
)(
    input clk, 
    input w_en, 
    input [$clog2(DEPTH)-1:0] addr, 
    input [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out
);

    // Memory array
    reg [WIDTH-1:0] mem [0:DEPTH-1];
  
    always @(posedge clk) begin
        if (w_en) begin
            mem[addr] <= data_in;
        end 
        data_out <= mem[addr]; 
    end

endmodule
