`timescale 1ns / 1ps


module Register_file(
    input clk,
    input [4:0] read_addr1,
    input [4:0] read_addr2,
    input [4:0] write_addr,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2,
    input regwrite
    );
	 
	 reg [31:0] regfile [31:0];
	 initial regfile[0] = 0;
	 
	 always @(posedge clk)
	 begin
		regfile[0] = 0;
		if(regwrite)
			regfile[write_addr] <= write_data;
	 end
	  assign read_data1 = regfile[read_addr1];
	  assign read_data2 = regfile[read_addr2];
	  


endmodule
