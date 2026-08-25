`timescale 1ns / 1ps

module fsm_controller (
    input  wire       clk,
    input  wire       rst_n,
    input  wire [3:0] req,
    output reg        enable_gnt,
    output reg  [1:0] ptr
);

    parameter IDLE  = 1'b0;
    parameter GRANT = 1'b1;

    reg state, next_state;


    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) state <= IDLE;
        else  state <= next_state;
    end


    always @(*) begin
        next_state = state;
        enable_gnt = 1'b0;

        if (req != 4'b0000) begin
            enable_gnt = 1'b1;
            next_state = GRANT;
        end else begin
            next_state = IDLE;
        end
    end


    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ptr <= 2'd1;
        end 
        else if (enable_gnt && !req[0] && req[3:1] != 3'b000) begin
         
            if (ptr == 2'd3) 
                ptr <= 2'd1;
            else 
                ptr <= ptr + 1'b1; 
        end
    end
endmodule
