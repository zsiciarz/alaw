module alaw_test;

reg [7:0] input_lin;
wire [7:0] output_alaw;
wire [7:0] output_decoded;
reg [7:0] error;

// input_lin -> [coder] -> output_alaw -> [decoder] -> output_decoded
alaw_coder coder(.input_lin(input_lin), .output_alaw(output_alaw));
alaw_decoder decoder(.input_alaw(output_alaw), .output_lin(output_decoded));

initial begin
    $display("Running testbench...");
    input_lin = 0;
    //$monitor("%b ==> %b ==> %b", input_lin, output_alaw, output_decoded);
    for (input_lin = 0; input_lin < 8'b11111111; input_lin = input_lin + 1) begin
        #5 error = output_decoded & ~input_lin;
        // is there any bit in error set?
        if (|error) begin
            $display("error at iteration #%d", input_lin);
        end
    end
    $finish;
end

endmodule

