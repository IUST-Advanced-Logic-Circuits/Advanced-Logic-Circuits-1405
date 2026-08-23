`timescale 1ns / 1ps

module grant_generator #(parameter N = 4) (
    input  wire	clk,
    input  wire	rst_n,
    input  wire	[N-1:0] winner, 
    input  wire	enable,
    output reg    [N-1:0] gnt
		);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            gnt <= 4'b0000;
        end else begin
            if (enable)
                gnt <= winner; 
            else
                gnt <= 4'b0000;
        end
    end
endmodule
