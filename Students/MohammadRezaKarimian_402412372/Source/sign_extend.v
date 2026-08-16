`timescale 1ns / 1ps

module sign_extend(
    input [15:0] data_in,
    output reg[31:0] data_out
    );

	always @(*)
	begin
		if (~data_in[15])
			data_out = {16'b0,data_in};
		else
			data_out = {16'b1111111111111111,data_in};
	end
endmodule
