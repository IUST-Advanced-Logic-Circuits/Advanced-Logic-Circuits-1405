`timescale 1ns / 1ps

module grant_generator (
    input  wire       clk,
    input  wire       rst_n,
    input  wire [3:0] winner, 
    input  wire       enable, 
    output reg  [3:0] gnt
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
