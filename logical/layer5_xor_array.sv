module layer5_xor_array(
    input logic [255:0] in,
    output logic [255:0] out

);
genvar i;
generate;
    for (i = 0;i<16;i++) begin
        xor_gate u_xor_gate ( .A(in[128+7+8*i:128+8*i]), .B(in[127:120]), .Y(out[128+7+8*i:128+8*i]));       
    end
endgenerate
assign out[127:0] = in[127:0];
endmodule