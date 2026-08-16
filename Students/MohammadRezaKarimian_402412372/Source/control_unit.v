`timescale 1ns / 1ps

module control_unit(
    input clk,
    input reset,
    input [5:0] upcode, //instruction[31-26]
	 output reg [3:0] ALUop,
	 output reg jump,
	 output reg branch,
	 output reg memory_read,
	 output reg memory_write,
	 output reg memory_to_reg,
	 output reg ALUSrc,
	 output reg reg_write,
	 output reg regdst
    );
		
		always @(*)
    begin
        case(upcode)
        6'b000000 : begin ALUop = 4'b0000; jump=0; branch=0; memory_read=0; memory_write=0; memory_to_reg=0; ALUSrc=0; reg_write=1; regdst=1; end // R-type
        6'b100011 : begin ALUop = 4'b0001; jump=0; branch=0; memory_read=1; memory_write=0; memory_to_reg=1; ALUSrc=1; reg_write=1; regdst=0; end // LW
        6'b101011 : begin ALUop = 4'b0010; jump=0; branch=0; memory_read=0; memory_write=1; memory_to_reg=0; ALUSrc=1; reg_write=0; regdst=0; end // SW
        6'b000100 : begin ALUop = 4'b0011; jump=0; branch=1; memory_read=0; memory_write=0; memory_to_reg=0; ALUSrc=0; reg_write=0; regdst=0; end // BEQ
        6'b000101 : begin ALUop = 4'b0100; jump=0; branch=1; memory_read=0; memory_write=0; memory_to_reg=0; ALUSrc=0; reg_write=0; regdst=0; end // BNQ
        6'b000010 : begin ALUop = 4'b0101; jump=1; branch=0; memory_read=0; memory_write=0; memory_to_reg=0; ALUSrc=0; reg_write=0; regdst=0; end // JUMP
        6'b001000 : begin ALUop = 4'b0110; jump=0; branch=0; memory_read=0; memory_write=0; memory_to_reg=0; ALUSrc=1; reg_write=1; regdst=0; end // ADDI
        6'b001100 : begin ALUop = 4'b0111; jump=0; branch=0; memory_read=0; memory_write=0; memory_to_reg=0; ALUSrc=1; reg_write=1; regdst=0; end // ANDI
        6'b001101 : begin ALUop = 4'b1000; jump=0; branch=0; memory_read=0; memory_write=0; memory_to_reg=0; ALUSrc=1; reg_write=1; regdst=0; end // ORI
        6'b001010 : begin ALUop = 4'b1001; jump=0; branch=0; memory_read=0; memory_write=0; memory_to_reg=0; ALUSrc=1; reg_write=1; regdst=0; end // SLTI
        default :   begin ALUop = 4'b0001; jump=0; branch=0; memory_read=0; memory_write=0; memory_to_reg=0; ALUSrc=0; reg_write=0; regdst=0; end
        endcase
		
		end

endmodule
