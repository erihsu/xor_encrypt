module layer12_xor_array(
    input logic [31:0] in,  
    output logic [31:0] out
);
logic [7:0] tmp1;
xor_gate u1_xor_gate (
    .A    (in[31:24]),
    .B    (in[23:16]),
    .Y    (tmp1)
);

xor_gate u2_xor_gate (
    .A    (in[15:8]),
    .B    (in[7:0]),
    .Y    (out[15:8])
);

xor_gate u3_xor_gate (
    .A    (tmp1),
    .B    (out[15:8]),
    .Y    (out[31:24])
);

xor_gate u4_xor_gate (
    .A    (in[23:16]),
    .B    (out[15:8]),
    .Y    (out[23:16])
);
assign out[7:0] = in[7:0];
endmodule