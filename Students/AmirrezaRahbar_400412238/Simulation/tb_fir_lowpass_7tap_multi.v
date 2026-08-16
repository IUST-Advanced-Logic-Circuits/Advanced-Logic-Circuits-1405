`timescale 1ns/100ps

module tb_fir_lowpass_7tap_multi;
reg clk , rst;
reg [7:0] sample_index;
//test cases
reg [7:0] x_step;
reg [7:0] x_fast;
reg [7:0] x_impulse;
reg [7:0] x_sine_low;
reg [7:0] x_sine_high;

// outputs for test cases
wire [7:0] y_step;
wire [7:0] y_fast;
wire [7:0] y_impulse;
wire [7:0] y_sine_low;
wire [7:0] y_sine_high;

integer i;

fir_lowpass_7tap f_step(clk , rst , x_step , y_step);
fir_lowpass_7tap f_fast(clk , rst , x_fast , y_fast);
fir_lowpass_7tap f_impulse(clk , rst , x_impulse , y_impulse);
fir_lowpass_7tap f_sine_low(clk , rst , x_sine_low , y_sine_low);
fir_lowpass_7tap f_sine_high(clk , rst , x_sine_high , y_sine_high);

//sine wave - low frequency - offset=128
function [7:0] low_sine;
input [4:0] k;
begin
    case (k)
        5'd0:  low_sine = 8'd128;
        5'd1:  low_sine = 8'd153;
        5'd2:  low_sine = 8'd177;
        5'd3:  low_sine = 8'd199;
        5'd4:  low_sine = 8'd218;
        5'd5:  low_sine = 8'd234;
        5'd6:  low_sine = 8'd245;
        5'd7:  low_sine = 8'd253;
        5'd8:  low_sine = 8'd255;
        5'd9:  low_sine = 8'd253;
        5'd10: low_sine = 8'd245;
        5'd11: low_sine = 8'd234;
        5'd12: low_sine = 8'd218;
        5'd13: low_sine = 8'd199;
        5'd14: low_sine = 8'd177;
        5'd15: low_sine = 8'd153;
        5'd16: low_sine = 8'd128;
        5'd17: low_sine = 8'd103;
        5'd18: low_sine = 8'd79;
        5'd19: low_sine = 8'd57;
        5'd20: low_sine = 8'd38;
        5'd21: low_sine = 8'd22;
        5'd22: low_sine = 8'd11;
        5'd23: low_sine = 8'd3;
        5'd24: low_sine = 8'd1;
        5'd25: low_sine = 8'd3;
        5'd26: low_sine = 8'd11;
        5'd27: low_sine = 8'd22;
        5'd28: low_sine = 8'd38;
        5'd29: low_sine = 8'd57;
        5'd30: low_sine = 8'd79;
        default: low_sine= 8'd103;
    endcase
end
endfunction

//sine wave - high frequency
function [7:0] high_sine;
input [1:0] k;
begin
    case (k)
        2'd0: high_sine = 8'd128;
        2'd1: high_sine= 8'd255;
        2'd2: high_sine= 8'd128;
        default: high_sine =8'd1;
    endcase
end
endfunction

//clock T = 10nS
initial
begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial
begin
    $display("time index step y_step fast y_fast impulse y_impulse sine_low y_sine_low sine_high y_sine_high");
    $monitor("%0t %d %d %d %d %d %d %d %d %d %d %d",
             $time,sample_index,
             x_step,y_step,
             x_fast,y_fast,
             x_impulse,y_impulse,
             x_sine_low,y_sine_low,
             x_sine_high,y_sine_high);

//initial values and reset
    rst=1;
    sample_index = 8'd0;
    x_step = 8'd0;
    x_fast = 8'd0;
    x_impulse = 8'd0;
    x_sine_low= 8'd128;
    x_sine_high = 8'd128;

    #12 rst = 0;

    for (i = 0; i < 96; i = i + 1)
    begin
        @(negedge clk);
        sample_index = i;
        //input = step wave (change quickly from 0 to 200)
        if (i < 8)
            x_step = 8'd0;
        else
            x_step = 8'd200;
        
        //input = periodical input change between 0 to 200
        if ((i % 2) == 0)
            x_fast =8'd0;
        else
            x_fast = 8'd200;
        //input = impulse wave
        if (i == 12)
            x_impulse= 8'd255;
        else
            x_impulse = 8'd0;
        //input = low and high frequency
        x_sine_low = low_sine(i%32);
        x_sine_high= high_sine(i%4);
    end

    #40 $stop;
end

endmodule
