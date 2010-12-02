module alaw_test;

wire [7:0] input_lin;
wire [7:0] output_alaw;
wire [7:0] output_decoded;

// input_lin -> [koder] -> output_alaw -> [dekoder] -> output_decoded
alaw_coder coder(.input_lin(input_lin), .output_alaw(output_alaw));
alaw_decoder decoder(.input_alaw(output_alaw), .output_lin(output_decoded));

endmodule

