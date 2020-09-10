`timescale 1ns/1ps
module xor_scoreboard(
        input logic clk,
        input logic rst_n,
        input logic [255:0] code1,
        input logic [255:0] code2,
        input logic valid1,
        input logic valid2,
        output logic err_n,
        output logic pass
);
    logic err_vn,err_cn;
    assign err_vn = (valid1==valid2);
    assign err_cn = (code1 == code2);
    assign err_n  = err_cn & err_vn;

    always_ff @(posedge clk) begin
        if (!err_vn)
            $display("ERROR: wrong valid @t = %t",$time);
    end

    always_ff @(posedge clk) begin
        if (!err_cn)
            $display("ERROR: wrong result @t = %t",$time);
    end

    always_ff @(posedge clk) begin
        if (!rst_n) pass <= 1'b1;
        else if (!err_n) pass <= 1'b0;
    end
endmodule