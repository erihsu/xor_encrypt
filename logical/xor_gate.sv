module xor_gate(
    input logic [7:0] A,
    input logic [7:0] B,
    output logic [7:0] Y
);
    assign Y = A^B;
endmodule