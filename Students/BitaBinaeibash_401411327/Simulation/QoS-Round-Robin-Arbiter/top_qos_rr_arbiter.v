`timescale 1ns / 1ps

module top_qos_rr_arbiter (
    input  wire       clk,
    input  wire       rst_n,
    input  wire [3:0] req, 
    output wire [3:0] gnt   
);

    wire [3:0] winner_sig;
    wire [1:0] ptr_sig;
    wire       enable_sig;

    
    priority_logic u_priority (
        .req(req),
        .ptr(ptr_sig),
        .winner(winner_sig)
    );

    
    grant_generator u_grant (
        .clk(clk),
        .rst_n(rst_n),
        .winner(winner_sig),
        .enable(enable_sig),
        .gnt(gnt)
    );

    fsm_controller u_fsm (
        .clk(clk),
        .rst_n(rst_n),
        .req(req),
        .enable_gnt(enable_sig),
        .ptr(ptr_sig)
    );

endmodule
