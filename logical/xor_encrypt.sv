`timescale 1ns/1ps
module xor_encrypt(
        input logic clk,
        input logic valid_in,
        input logic [7:0] key,
        input logic [255:0] code,
        output logic [255:0] code_out,
        output logic valid_out 
);

logic [255:0] code_out_w;
wire [255:0] tmp1;
wire [255:0] tmp2;
wire [255:0] tmp3;

logic [7:0] xor_key;

xor_gate u_xor_gate ( .A(code[7:0]), .B(key), .Y(xor_key));

genvar i;
generate;
    for (i=0;i<8;i++) begin
        if (i==0) begin
            layer12_xor_array u_layer12_xor_array ( .in({code[31:8],xor_key}), .out(tmp1[31:0]));
        end
        else begin
            layer12_xor_array u_layer12_xor_array ( .in(code[31+32*i:32*i]), .out(tmp1[31+32*i:32*i]));
        end
    end
endgenerate

generate;
    for (i=0;i<4;i++) begin
        layer3_xor_array u_layer3_xor_array ( .in(tmp1[63+64*i:64*i]), .out(tmp2[63+64*i:64*i]));
    end
endgenerate

generate;
    for (i=0;i<2;i++) begin
        layer4_xor_array u_layer4_xor_array ( .in(tmp2[127+128*i:128*i]), .out(tmp3[127+128*i:128*i]));
    end
endgenerate

layer5_xor_array u_layer5_xor_array ( .in(tmp3), .out(code_out_w));

always_ff @(posedge clk) begin
    valid_out <= valid_in;
end

always_ff @(posedge clk) begin
    if (valid_in) code_out <= code_out_w;
end

endmodule