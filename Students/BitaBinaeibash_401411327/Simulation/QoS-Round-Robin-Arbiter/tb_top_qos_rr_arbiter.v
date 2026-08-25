`timescale 1ns / 1ps

module tb_top_qos_rr_arbiter();

  
    reg  clk;
    reg  rst_n;
    reg  [3:0] req;
    wire [3:0] gnt;

    top_qos_rr_arbiter uut (
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

        rst_n = 0;
        req   = 4'b0000;
        #20; 
        rst_n = 1; 
        #10;

        $display("---------------------------------------------------");
        
       
        $display("Time: %0t | Scenario 1: VIP Only", $time);
        req = 4'b0001; 
        #10; 
        req = 4'b0000; 
        #20;

      
        $display("Time: %0t | Scenario 2: Normal Traffic Congestion", $time);
        req = 4'b1110; 
        #10; 
        #10; 
        #10;
        req = 4'b0000; 
        #20;

      
        $display("Time: %0t | Scenario 3: Full Congestion (req = 1111)", $time);
        req = 4'b1111; 
        #10; 
        

        req = 4'b1110; 
        #10;
        #10; 
        #10;
        req = 4'b0000; 
        #20;


        $display("Time: %0t | Scenario 4: VIP Interrupting Smart RR", $time);
        req = 4'b1010; 
        #10; 
        
        req = 4'b1011; 
        #10;
        
        req = 4'b1010; 
        #10; 
        
        req = 4'b0000;
        #30;

        $display("---------------------------------------------------");
        $display("Simulation Finished Successfully!");
        $stop;
    end

   
    initial begin
        $monitor("Time: %3t ns | req: %b => gnt: %b | FSM State: %b | RR Pointer: %d", 
                  $time, req, gnt, uut.u_fsm.state, uut.u_fsm.ptr);
    end

endmodule
