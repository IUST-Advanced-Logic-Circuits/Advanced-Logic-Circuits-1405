`timescale 1ns / 1ps


module ALU(
    input [31:0] data_in1,
    input [31:0] data_in2,
    input [2:0] op,
    output reg[31:0] result,
    output reg zero
    );
	 reg data_compare;
	 
	 always @(*)
	 begin
		case(op)
		3'b000 : begin result = data_in1 + data_in2; end
		3'b001 : begin result = data_in1 - data_in2; end
		3'b010 : begin result = data_in1 & data_in2; end
		3'b011 : begin result = data_in1 | data_in2; end
		3'b100 : begin if(data_compare == 1) result = 1; else result = 0; end
		default : result = 0;
		endcase
	 end
	
	always @(*)
	begin
		case({data_in1[31],data_in2[31]})
		2'b00 : begin if (data_in1 < data_in2) data_compare=1; else data_compare=0; end
		2'b01 : data_compare=0;
		2'b10 : data_compare=1;
		2'b11 : begin if (~data_in1 + 1 > ~data_in2 + 1) data_compare=1; else data_compare=0; end
		endcase
	end

	always @(*)
	begin
		if(result==0)
			zero = 1;
		else
			zero = 0;
	end
	
endmodule
