// D Flip Flop Verification
module d_ff(intr_dff.dut_mp intr);
  
  always @ (posedge intr.clk or posedge intr.rst) begin
    if (intr.rst)
      intr.q <= 1'b0;
    else
      intr.q <= intr.d;
  end
  
endmodule
