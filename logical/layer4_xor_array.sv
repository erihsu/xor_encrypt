module layer4_xor_array(
    input logic [127:0] in,
    output logic [127:0] out

);
genvar i;
generate;
    for (i = 0;i<8;i++) begin
        xor_gate u_xor_gate ( .A(in[64+7+8*i:64+8*i]), .B(in[63:56]), .Y(out[64+7+8*i:64+8*i]));       
    end
endgenerate
assign out[63:0] = in[63:0];
endmodule