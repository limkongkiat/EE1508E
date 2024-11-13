`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2024 00:01:52
// Design Name: 
// Module Name: results_display
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


module results_display(
    input clk_25M,
    input [12:0] pix_idx,
    input [6:0] x_pos, [5:0] y_pos,
    input signed [4:0] curr_score,
    output reg [15:0] results_screen = 0,
    output isCurrentScore
    );

    wire [15:0] score_disp;
    BRAM_quiz_results_screen qrs (.clk(clk_25M), .addr(pix_idx), .read_write(0), .data_in(0), .data_out(score_disp));

    always @ (posedge clk_25M) begin
        results_screen <= score_disp;
    end

    localparam [1:0] SCORE_SCALE = 2'd2; localparam [6:0] SCORE_OFFSET_X = 7'd16;
    localparam [6:0] SCORE_START_X = 7'd25; localparam [5:0] SCORE_START_Y = 6'd25;

    signed_dig_disp current_score (
        .clk(clk_25M), .curr_x(x_pos), .curr_y(y_pos), .left_x(SCORE_START_X), .top_y(SCORE_START_Y),
        .scale(SCORE_SCALE), .digit(curr_score), .isDigit(isCurrentScore)
    );
    
endmodule
