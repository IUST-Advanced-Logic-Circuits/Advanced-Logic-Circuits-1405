`timescale 1ns / 1ps

module MUX2(
    input [31:0] data_in1,
    input [31:0] data_in2,
    input select,
    output reg[31:0] data_out
    );

	always @(*)
	begin
		if(~select)
			data_out = data_in1;
		else
			data_out = data_in2;
	
	end
endmodule
