`timescale 1ns / 1ps

module tb_top_arbiter();

    parameter N = 4;

 
    reg  clk;
    reg  rst_n;
    reg  [N-1:0] req;


    wire [N-1:0] gnt;


    top_arbiter #(N) uut (
        .clk(clk),
        .rst_n(rst_n),
        .req(req),
        .gnt(gnt)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        $monitor("Time=%0t | rst_n=%b | req=%b | gnt=%b", $time, rst_n, req, gnt);

        $display("\n--- Starting Simulation ---");

        rst_n = 0;
        req = 4'b0000;
        #15; 
        rst_n = 1; 
        #10;

        $display("\n--- Single Request ---");
        req = 4'b0001; 
        #20;
        req = 4'b0000; 
        #10;

        $display("\n--- Simultaneous Requests (Round-Robin Check) ---");
        req = 4'b1111; 
        

        #20; 
        #20; 
        #20; 
        #20; 
        #20; 

  
        req = 4'b0000;
        #20;


        $display("\n--- Two Clients Requesting ---");
        req = 4'b1010; 
        #20;
        #20; 
        #20; 

        $display("\n--- Simulation Complete ---");
        $finish; 
    end

endmodule
