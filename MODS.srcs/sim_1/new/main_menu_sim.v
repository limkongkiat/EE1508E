`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2024 10:58:17
// Design Name: 
// Module Name: main_menu_sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module main_menu_sim(

    );
    reg CLOCK = 0;
    
    wire MHz25;
    flexi_clock clk_25MHz (.basys_clk(CLOCK), .my_m_value(1), .my_clk(MHz25));
    
    wire Hz4;
    flexi_clock clk_4Hz (CLOCK, 12_499, Hz4);
    
//    wire [4:0] A = 5'd1, B = 5'd2, C = 5'd3, D = 5'd4, E = 5'd5;
//    wire [4:0] F = 5'd6, G = 5'd7, H = 5'd8, I = 5'd9, J = 5'd10;
//    wire [4:0] K = 5'd11, L = 5'd12, M = 5'd13, N = 5'd14, O = 5'd15;
//    wire [4:0] P = 5'd16, Q = 5'd17, R = 5'd18, S = 5'd19, T = 5'd20;
//    wire [4:0] U = 5'd21, V = 5'd22, W = 5'd23, X = 5'd24, Y = 5'd25, Z = 5'd26;
    
//    // Wire definition for space, comma, and period
//    wire [4:0] period = 5'd27; // Period (.)
//    wire [4:0] comma = 5'd28;  // Comma (,)
//    wire [4:0] spc = 5'd0;    // Space
    
    reg btnU, btnD, btnL, btnR;
    
//    // need to reverse because little endian
//    function [39:0] reverse_bits(input [39:0] in);
//        integer i;
//        begin
//            for (i = 0; i < 8; i = i + 1) begin
//                reverse_bits[5*i +: 5] = in[5*(7-i) +: 5];
//            end
//        end
//    endfunction
    
//    wire [39:0] title;
//    assign title = reverse_bits({D, I, A, G, O, N, A, L});
    
    wire MHz6p25;
    flexi_clock clk_6p25MHz (CLOCK, 7, MHz6p25);
    
    reg [12:0] pix_idx;
    wire [6:0]curr_x;
    wire [5:0]curr_y;
    assign curr_x = pix_idx % 96;
    assign curr_y = pix_idx / 96;
    wire [15:0] oled_colour;
    wire isOrderNum;
    reg signed [4:0] counter = 0;
    
    signed_dig_disp sdd(
        .clk(MHz25), .curr_x(curr_x), .curr_y(curr_y), 
        .left_x(37), .top_y(2), .scale(2), .digit(0), 
        .isDigit(isOrderNum));
        
    initial begin
        pix_idx = 0;
//        btnU = 0;
       btnD = 1;
//        btnL = 0;
//        btnR = 0;
    end
    
    always @ (posedge MHz6p25) begin
        pix_idx <= (pix_idx == 6143) ? 0: pix_idx + 1;
    end
    
    always @ (posedge Hz4) begin
        counter <= counter == 9 ? -9 : counter + 1;
    end
    
    always begin
        #5 CLOCK <= ~CLOCK;
    end
endmodule
