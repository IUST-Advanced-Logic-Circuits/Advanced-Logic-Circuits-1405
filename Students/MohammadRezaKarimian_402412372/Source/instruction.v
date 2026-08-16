`timescale 1ns / 1ps

module instruction(
    input [31:0] address,
    output [31:0] read_data
    );

	reg [31:0] mem_array [127:0];
	
	assign read_data = mem_array[address[31:2]];
	
	initial
	begin
		$readmemb ("instrmem_test.txt",mem_array);
	end
endmodule
