`timescale 1ns / 1ps

module CPU(
    input Clock,
    input Reset
    );

	wire jump ,branch ,memory_read ,memory_write ,memory_to_reg ,ALUSrc ,reg_write ,regdst;
	wire [3:0] ALUop;
	wire [5:0] upcode;
	
	datapath F1 (Clock,Reset,jump,branch,memory_read,memory_write,memory_to_reg,ALUSrc,reg_write,regdst,ALUop,upcode);
	
	control_unit F2 (Clock,Reset,upcode,ALUop,jump,branch,memory_read,memory_write,memory_to_reg,ALUSrc,reg_write,regdst);
	
endmodule


