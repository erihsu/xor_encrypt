`timescale 1ns/1ps
module xor_golden(
        input logic clk,
        input logic valid_in,
        input logic [7:0] key,
        input logic [255:0] code,
        output logic [255:0] code_out,
        output logic         valid_out
);
    reg [255:0] code_out_w;

    assign code_out_w[7:0] = code[7:0]^key;
    
    genvar i;
    generate;
        for(i=1;i<256/8;i++) begin
            assign code_out_w[i*8+7:i*8] = code[i*8+7:i*8]^code_out_w[(i-1)*8+7:(i-1)*8];
        end
    endgenerate

    always_ff @(posedge clk) begin
        if(valid_in)
            code_out <= code_out_w;        
    end

    always_ff @(posedge clk) begin
        valid_out <= valid_in;
    end
endmodule