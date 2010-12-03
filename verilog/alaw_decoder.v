module alaw_decoder(input_alaw, output_lin);

input [7:0] input_alaw;
output [12:0] output_lin;

reg [11:0] output_unsigned;

always @(input_alaw) begin
    if (input_alaw[6:4] == 3'b000) begin
        output_unsigned = {7'b000_0000, input_alaw[3:0], 1'b1};
    end
    else if (input_alaw[6:4] == 3'b001) begin
        output_unsigned = {7'b000_0001, input_alaw[3:0], 1'b1};
    end
    else if (input_alaw[6:4] == 3'b010) begin
        output_unsigned = {6'b00_0001, input_alaw[3:0], 2'b10};
    end
    else if (input_alaw[6:4] == 3'b011) begin
        output_unsigned = {5'b0_0001, input_alaw[3:0], 3'b100};
    end
    else if (input_alaw[6:4] == 3'b100) begin
        output_unsigned = {4'b0001, input_alaw[3:0], 4'b1000};
    end
    else if (input_alaw[6:4] == 3'b101) begin
        output_unsigned = {3'b001, input_alaw[3:0], 5'b1_0000};
    end
    else if (input_alaw[6:4] == 3'b110) begin
        output_unsigned = {2'b01, input_alaw[3:0], 6'b10_0000};
    end
    else if (input_alaw[6:4] == 3'b111) begin
        output_unsigned = {1'b1, input_alaw[3:0], 7'b100_0000};
    end
    else begin
        output_unsigned = {7'b000_0000, input_alaw[3:0], 1'b1};
    end
end

// TODO: keep the sign bit here!
assign output_lin = {1'b0, output_unsigned};

endmodule

