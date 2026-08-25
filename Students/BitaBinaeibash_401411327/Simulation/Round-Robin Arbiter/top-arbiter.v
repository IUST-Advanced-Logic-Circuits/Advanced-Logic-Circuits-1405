`timescale 1ns / 1ps

module top_arbiter #(parameter N = 4) (
    input  wire	clk,
    input  wire	rst_n,
    input  wire	[N-1:0] req,
    output wire	[N-1:0] gnt
		);

    wire [N-1:0] winner_sig;
    wire	[1:0] ptr_sig;
    wire enable_sig;
    wire	any_req_sig;


    assign any_req_sig = |req; 

    priority_logic #(N) u_priority (
        .req(req),
        .ptr(ptr_sig),
        .winner(winner_sig)
    );

    grant_generator #(N) u_grant (
        .clk(clk),
        .rst_n(rst_n),
        .winner(winner_sig),
        .enable(enable_sig),
        .gnt(gnt)
    );

    fsm_controller u_fsm (
        .clk(clk),
        .rst_n(rst_n),
        .any_req(any_req_sig),
        .enable_gnt(enable_sig),
        .ptr(ptr_sig)
    );

endmodule