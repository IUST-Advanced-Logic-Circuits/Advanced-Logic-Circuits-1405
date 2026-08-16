`timescale 1ns/100ps

module fir_lowpass_7tap(clk , rst , x_in , y_out);
input clk , rst;
input [7:0] x_in;
output [7:0] y_out;

reg [7:0] x0 , x1 , x2 , x3 , x4 , x5 , x6;
wire [9:0] p0 , p1 , p2 , p3 , p4 , p5 , p6;
wire [11:0] sum; 

parameter h0 = 1;
parameter h1 = 2;
parameter h2 = 3;
parameter h3 = 4;
parameter h4 =3;
parameter h5 = 2;
parameter h6 = 1;

always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        x0 <= 8'b00000000;
        x1 <= 8'b00000000;
        x2 <= 8'b00000000;
        x3 <= 8'b00000000;
        x4 <= 8'b00000000;
        x5 <= 8'b00000000;
        x6 <= 8'b00000000;
    end
    else
    begin
        x6 <= x5;
        x5 <= x4;
        x4 <= x3;
        x3 <= x2;
        x2 <= x1;
        x1 <= x0;
        x0 <= x_in;
    end
end

assign p0 = x0*h0;
assign p1 = x1*h1;
assign p2 = x2*h2;
assign p3 = x3*h3;
assign p4 = x4*h4;
assign p5 = x5*h5;
assign p6 = x6*h6;

assign sum = {2'b00 , p0} + {2'b00 , p1} + {2'b00 , p2} + {2'b00 , p3} + {2'b00 , p4} + {2'b00 , p5} + {2'b00 , p6};
assign y_out = sum[11:4];

endmodule
