`timescale 1ns / 1ps

module fsm_controller (
    input  wire clk,
    input  wire rst_n,
    input  wire any_req,    
    output reg  enable_gnt,  
    output reg  [1:0] ptr 
		);

    
    parameter IDLE  = 1'b0;
    parameter GRANT = 1'b1; 

    reg state, next_state;

    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) state <= IDLE;
        else        state <= next_state;
    end

    
    always @(*) begin
        next_state = state;
        enable_gnt = 1'b0;

        case (state)
            IDLE: begin
                if (any_req) begin
                    next_state = GRANT; 
                end
            end
            
            GRANT: begin
                enable_gnt = 1'b1;
                if (!any_req) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

 
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ptr <= 2'd0;
        end else if (state == GRANT && any_req) begin
            ptr <= ptr + 1'b1; 
        end
    end
endmodule
