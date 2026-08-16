`timescale 1ns / 1ps

module PC(
    input clk,
    input reset,
    input [31:0] data_in,
    output reg [31:0] data_out
    );

	always @(posedge clk or posedge reset)
	begin
	if (reset==1)
		data_out = 0;
	else
		data_out = data_in;
	end
	
endmodule
