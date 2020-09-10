module layer3_xor_array(
    input logic [63:0] in,
    output logic [63:0] out

);
genvar i;
generate;
    for (i = 0;i<4;i++) begin
        xor_gate u_xor_gate ( .A(in[32+7+8*i:32+8*i]), .B(in[31:24]), .Y(out[32+7+8*i:32+8*i]));       
    end
endgenerate
assign out[31:0] = in[31:0];
endmodule