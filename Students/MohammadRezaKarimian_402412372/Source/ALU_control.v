`timescale 1ns / 1ps

module ALU_control(
    input [3:0] ALUop,
    input [5:0] func,
    output reg[2:0] op
    );
	
	always @(*)
	begin
		casex({ALUop,func})
		10'b0000100000 : op = 3'b000; // R type add
		10'b0000100010 : op = 3'b001; // R type sub
		10'b0000100100 : op = 3'b010; // R type and
		10'b0000100101 : op = 3'b011; // R type or
		10'b0000101010 : op = 3'b100; // R type compare
		10'b0001xxxxxx : op = 3'b000; // LW
		10'b0010xxxxxx : op = 3'b000; // SW
		10'b0011xxxxxx : op = 3'b001; // beq
		10'b0100xxxxxx : op = 3'b001; // bnq
		10'b0101xxxxxx : op = 3'b000; // jump
		10'b0110xxxxxx : op = 3'b000; // add immediate
		10'b0111xxxxxx : op = 3'b010; // and immediate
		10'b1000xxxxxx : op = 3'b011; // or immediate
		10'b1001xxxxxx : op = 3'b100; // compare immediate
		
	
		endcase
	end
	
endmodule
