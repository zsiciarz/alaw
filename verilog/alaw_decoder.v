module alaw_decoder(input_alaw, output_lin);

input [7:0] input_alaw;
output [12:0] output_lin;

reg [11:0] output_unsigned;
reg [3:0] bits;

always @(input_alaw) begin
    bits = input_alaw[3:0];
    case(input_alaw[6:4])
        3'b000:  output_unsigned = {7'b000_0000, bits, 1'b1};
        3'b001:  output_unsigned = {7'b000_0001, bits, 1'b1};
        3'b010:  output_unsigned = {6'b00_0001, bits, 2'b10};
        3'b011:  output_unsigned = {5'b0_0001, bits, 3'b100};
        3'b100:  output_unsigned = {4'b0001, bits, 4'b1000};
        3'b101:  output_unsigned = {3'b001, bits, 5'b1_0000};
        3'b110:  output_unsigned = {2'b01, bits, 6'b10_0000};
        3'b111:  output_unsigned = {1'b1, bits, 7'b100_0000};
        default: output_unsigned = {7'b000_0000, bits, 1'b1};
    endcase
end

assign output_lin = {input_alaw[7], output_unsigned};

endmodule

