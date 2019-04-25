module signExtendTarget (in, out);
  input [26:0] in;
  output [31:0] out;

  assign out = (in[26] == 1) ? {5'b11111, in} : {5'b00000, in};
endmodule