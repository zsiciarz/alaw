// based on: http://www.young-engineering.com/docs/YoungEngineering_ALaw_and_MuLaw_Companding.pdf

module alaw_coder(input_lin, output_alaw);

input [12:0] input_lin;
output [7:0] output_alaw;

reg [6:0] output_unsigned;

always @(input_lin) begin
    if (input_lin[11:5] == 7'b000_0000) begin
        output_unsigned = {3'b000, input_lin[4:1]};
    end
    else if (input_lin[11:5] == 7'b000_0001) begin
        output_unsigned = {3'b001, input_lin[4:1]};
    end 
    else if (input_lin[11:6] == 6'b00_0001) begin
        output_unsigned = {3'b010, input_lin[5:2]};
    end 
    else if (input_lin[11:7] == 5'b0_0001) begin
        output_unsigned = {3'b011, input_lin[6:3]};
    end 
    else if (input_lin[11:8] == 4'b0001) begin
        output_unsigned = {3'b100, input_lin[7:4]};
    end 
    else if (input_lin[11:9] == 3'b001) begin
        output_unsigned = {3'b101, input_lin[8:5]};
    end 
    else if (input_lin[11:10] == 2'b01) begin
        output_unsigned = {3'b110, input_lin[9:6]};
    end 
    else if (input_lin[11] == 1'b1) begin
        output_unsigned = {3'b111, input_lin[10:7]};
    end 
    else begin
        output_unsigned = {3'b000, input_lin[4:1]};
    end
end

// TODO: keep the sign bit here!
assign output_alaw = {1'b0, output_unsigned};

endmodule

