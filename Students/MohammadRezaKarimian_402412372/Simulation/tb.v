`timescale 1ns / 1ps


module tb;

	reg Clock;
	reg Reset;

	CPU UUU (Clock,Reset);
	

	initial begin

		Clock = 0;
		Reset = 1;

		#5;
		
		Reset=0;

	end
      always #10 Clock=~Clock;
endmodule

