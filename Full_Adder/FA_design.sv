// Full Adder
module full_adder(
  input logic a, b, cin,
  output logic sum, carry);
  
  assign sum = a ^ b ^ cin;
  assign carry = ((a & b)|(b & cin)|(a & cin)); 
  
endmodule
