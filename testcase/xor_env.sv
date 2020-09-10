`timescale 1ns/1ps
module xor_env(
);
logic rst_n,clk;
logic pass;
logic [7:0] key_in;
logic [255:0] code_in,code_o1,code_o2;
logic valid_in,valid_o1,valid_o2;
logic err_n;
logic [31:0] count ,err_count;

initial begin
    clk = 0;
    forever
        #1 clk = ~clk;
end

xor_driver u_xor_driver (
    .clk       (clk),
    .enable    (rst_n),
    .key       (key_in),
    .code      (code_in),
    .valid     (valid_in)
);
xor_golden u_xor_golden (
    .clk          (clk),
    .valid_in     (valid_in),
    .key          (key_in),
    .code         (code_in),
    .code_out     (code_o1),
    .valid_out    (valid_o1)
);
xor_scoreboard u_xor_scoreboard (
    .clk       (clk),
    .rst_n     (rst_n),
    .code1     (code_o1),
    .code2     (code_o2),
    .valid1    (valid_o1),
    .valid2    (valid_o2),
    .err_n     (err_n),
    .pass      (pass)
);
xor_encrypt u_xor_encrypt (
    .clk          (clk),
    .valid_in     (valid_in),
    .key          (key_in),
    .code         (code_in),
    .code_out     (code_o2),
    .valid_out    (valid_o2)
);

always_ff @(posedge clk) begin
    if (!rst_n) count <= 32'h0;
    else if (valid_o1) count <= count + 32'b1;
end

always_ff @(posedge clk) begin
    if (!rst_n) err_count<=32'h0;
    else if (!err_n) err_count <= err_count + 32'b1;
end

initial begin
    rst_n = 0;
    $display("START\n");

    #5; 
    rst_n = 1;
    #30;

    if (pass)
        $display("%d tests PASSED!",count);
    else
        $display("ERROR: %d out of %d tests are WRONG!",err_count,count);

    #1;

    $finish;
end

endmodule