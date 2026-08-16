`timescale 1ns / 1ps

module data_memory(
    input [31:0] address,
    input [31:0] write_data,
    input clk,
    input memory_read,
    input memory_write,
    output reg [31:0] read_data
    );
	reg [31:0] mem_array [127:0];
	initial mem_array[101] = 34;
	
	always @(*)
	begin
		if(memory_read && ~memory_write)
			read_data = mem_array[address];
	end
	
	always @(posedge clk)
	begin
		if(~memory_read && memory_write)
			mem_array[address] = write_data;

	end
	
endmodule
