// Asynchronous FIFO - Design
module Asynchronous_fifo #(parameter DEPTH = 8, WIDTH = 8)(
    input w_clk, r_clk,
    input w_rst, r_rst,
    input w_en, r_en,
    input [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out,
    output full, empty);
  
    //Total number of address bits
    localparam addr = $clog2(DEPTH); 
    
    reg [WIDTH-1:0] mem [0:DEPTH-1];

    //WRITE POINTER

    reg [addr:0] w_ptr_bin, w_ptr_gray;

	wire [addr:0] w_ptr_bin_next = w_ptr_bin + 1;
	wire [addr:0] w_ptr_gray_next = (w_ptr_bin_next >> 1) ^ (w_ptr_bin_next);

  always@(posedge w_clk or posedge w_rst)begin
   	  if(w_rst)begin
        w_ptr_bin <= 0;
        w_ptr_gray <= 0;
     end
     else if(w_en && !full)begin
        w_ptr_bin <= w_ptr_bin_next;
        w_ptr_gray <= w_ptr_gray_next;
     end
    end

	//READ POINTER

	reg [addr:0] r_ptr_bin, r_ptr_gray;

	wire [addr:0] r_ptr_bin_next = r_ptr_bin + 1;
	wire [addr:0] r_ptr_gray_next = (r_ptr_bin_next >> 1) ^ r_ptr_bin_next;

  always@(posedge r_clk or posedge r_rst)begin
     if(r_rst)begin
        r_ptr_bin <= 0;
        r_ptr_gray <= 0;
     end
     else if(r_en && !empty)begin
        r_ptr_bin <= r_ptr_bin_next;
        r_ptr_gray <= r_ptr_gray_next;
     end
    end

    // 2 - FF SYNCHRONIZER READ_PTR to WRITE_CLK_DOMAIN

    reg [addr:0] rd_ptr_gray_sync1, rd_ptr_gray_sync2;

   	always@(posedge w_clk)begin
     if(w_rst)begin
        rd_ptr_gray_sync1 <= 0;
        rd_ptr_gray_sync2 <= 0;
     end
     else begin
        rd_ptr_gray_sync1 <= r_ptr_gray;
        rd_ptr_gray_sync2 <= rd_ptr_gray_sync1;
      end
     end

    // 2 - FF SYNCHRONIZER WRITE_PTR to READ_CLK_DOMAIN

    reg [addr:0] wr_ptr_gray_sync1, wr_ptr_gray_sync2;

    always@(posedge r_clk)begin
      if(r_rst)begin
        wr_ptr_gray_sync1 <= 0;
        wr_ptr_gray_sync2 <= 0;
     end
     else begin
        wr_ptr_gray_sync1 <= w_ptr_gray;
        wr_ptr_gray_sync2 <= wr_ptr_gray_sync1;
     end
    end

    // WRITE CONDITION

    always@(posedge w_clk)
      if(w_en && !full)
      mem[w_ptr_bin[addr-1:0]] <= data_in;

    // READ CONDITION

    always@(posedge r_clk)
      if(r_en && !empty)
        data_out <= mem[r_ptr_bin[addr-1:0]];

    // EMPTY CONDITION

     assign empty = (r_ptr_gray == wr_ptr_gray_sync2);

     // FULL CONDITION

      assign full = (w_ptr_gray_next == {!rd_ptr_gray_sync2 [addr:addr-1], rd_ptr_gray_sync2[addr-2:0]});

endmodule
