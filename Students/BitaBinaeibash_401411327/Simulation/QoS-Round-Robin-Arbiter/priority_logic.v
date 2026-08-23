`timescale 1ns / 1ps

module priority_logic (
    input  wire [3:0] req,  
    input  wire [1:0] ptr,  
    output reg  [3:0] winner
);

    always @(*) begin
        winner = 4'b0000; 
        
        if (req[0] == 1'b1) begin 
            winner = 4'b0001; 
        end 
       
        else if (req[3:1] != 3'b000) begin
            case (ptr)

                2'd1: if(req[1]) winner = 4'b0010; else if(req[2]) winner = 4'b0100; else winner = 4'b1000;

                2'd2: if(req[2]) winner = 4'b0100; else if(req[3]) winner = 4'b1000; else winner = 4'b0010;

                2'd3: if(req[3]) winner = 4'b1000; else if(req[1]) winner = 4'b0010; else winner = 4'b0100;

                default: if(req[1]) winner = 4'b0010; else if(req[2]) winner = 4'b0100; else winner = 4'b1000;
            endcase
        end
    end
endmodule
