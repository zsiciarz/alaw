module alaw_coder(input_lin, output_alaw);

input [7:0] input_lin;
output [7:0] output_alaw;

always @(input_lin) begin
    // TODO: A-law coder algorithm goes here ;)
end

assign output_alaw = input_lin; // for now, just pass-through

endmodule

