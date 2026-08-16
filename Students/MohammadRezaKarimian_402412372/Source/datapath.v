`timescale 1ns / 1ps

module datapath(
    input clk,
    input reset,
    input jump,
    input branch,
    input memory_read,
    input memory_write,
    input memory_to_reg,
    input ALUSrc,
    input reg_write,
    input regdst,
    input [3:0] ALUop,
    output [5:0] upcode
    );
	 
	 wire [4:0] o_mux1;
	 wire [31:0] o_mux2,o_mux3,o_mux4,o_mux5;
	 wire [31:0] pc,pc4,pc_b,pc_j,Ex,Ex2,instr,RF1,RF2,o_ALU,o_Mem,w;
	 wire [3:0] op;
	 wire [27:0] w1;
	 wire Zero,PCSrc;
	 
	PC U1 (clk,reset,o_mux5,pc);
	
	instruction U2 (pc,instr);
	assign upcode = instr[31:26];
	
	MUX1 U3 (instr[20:16],instr[15:11],regdst,o_mux1);
	
	Register_file U4 (clk,instr[25:21],instr[20:16],o_mux1,o_mux3,RF1,RF2,reg_write);
	
	sign_extend U5 (instr[15:0],Ex);
	
	MUX2 U6 (RF2,Ex,ALUSrc,o_mux2);
	
	ALU_control U7 (ALUop,instr[5:0],op);
	
	ALU U8 (RF1,o_mux2,op,o_ALU,Zero);
	
	data_memory U9 (o_ALU,RF2,clk,memory_read,memory_write,o_Mem);
	
	MUX2 U10 (o_ALU,o_Mem,memory_to_reg,o_mux3);
	
	ADD U11 (pc,32'd4,pc4);
	
	shift_left2 U12 ({6'b0,instr[25:0]},w);
	assign w1 = w[27:0];
	assign pc_j = ({pc[31:28],w1}); 
	
	shift_left2 U13 (Ex,Ex2);
	
	ADD U14 (pc4,Ex2,pc_b);
	
	assign PCSrc = branch & (Zero ^ instr[26]); // (why instr[26]? becuase beq upcode (instr[31:26]) is: 000100 and bnq upcode is : 000101)
	MUX2 U15 (pc4,pc_b,PCSrc,o_mux4);
	
	MUX2 U16 (o_mux4,pc_j,jump,o_mux5);
	

endmodule
