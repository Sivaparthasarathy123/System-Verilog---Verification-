// Counter Verification 
module counter(
  input clk, rst, en,
  output logic unsigned [2:0]q);
  
  always @(posedge clk or posedge rst) begin
    if (rst)
      q = 3'd0;
    else if (en)
      q = q + 1'd1;
    else if (!en) begin
      q = 7;
      q = q - 1'd1;
    end
  end
endmodule  
