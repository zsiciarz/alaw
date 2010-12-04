`timescale 10ns/1ps

module alaw_test;

reg [12:0] input_lin;
wire [7:0] output_alaw;
wire [12:0] output_decoded;
reg [12:0] error;

// input_lin -> [coder] -> output_alaw -> [decoder] -> output_decoded
alaw_coder coder(.input_lin(input_lin), .output_alaw(output_alaw));
alaw_decoder decoder(.input_alaw(output_alaw), .output_lin(output_decoded));

initial begin
    $display("Running testbench...");
    //$monitor("%b ==> %b ==> %b", input_lin, output_alaw, output_decoded);
    for (input_lin = 0; input_lin < 13'b1_1111_1111_1111; input_lin = input_lin + 1) begin
        // TODO: verify that decoded data approximates the linear input
        // since we lose some precision at least significant bits, it is
        // neccessary to find out another way of making sure it works

        #5 error = output_decoded & ~input_lin;
        // is there any bit in error set?
        if (|error) begin
            //$display("error at iteration #%d", input_lin);
        end
    end
    $finish;
end

initial begin
    $dumpfile("bin/out.vcd");
    $dumpvars(0, input_lin, output_alaw, output_decoded);
end

endmodule

