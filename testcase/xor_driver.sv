`timescale 1ns/1ps
module xor_driver(
    input logic clk,enable,
    output logic [7:0] key,
    output logic [255:0] code,
    output logic valid
);
    always_ff @(posedge clk) begin
        valid <= enable;
        key   <= $random;
        code[31:0] <= $random;
        code[63:32] <= $random;
        code[95:64] <= $random;
        code[127:96] <= $random;               
        code[159:128] <= $random;
        code[191:160] <= $random;
        code[223:192] <= $random;
        code[255:224] <= $random;

    end
endmodule