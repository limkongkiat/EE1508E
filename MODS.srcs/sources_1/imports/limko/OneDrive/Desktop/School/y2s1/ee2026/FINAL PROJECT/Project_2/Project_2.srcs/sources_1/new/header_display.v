`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2024 13:37:51
// Design Name: 
// Module Name: header_display
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


module header_display(
    input clk_25M,
    input [6:0] x_pos, [5:0] y_pos,
    input signed [4:0] question_num, signed [4:0] score, // TAKES IN unsigned [3:0] number
    output isHeader
    );

    localparam signed [4:0] Q = 5'd12;
    localparam signed [4:0] slash = 5'd13;
    localparam signed [4:0] space = 5'd15;

    localparam [0:0] SCALE = 1'd1;
    localparam [6:0] START_X = 7'd1;
    localparam [5:0] START_Y = 6'd1;
    localparam [3:0] X_OFFSET = 4'd8;

    wire isQ;
    wire isQuestionNumber;
    signed_dig_disp question (
        .clk(clk_25M), .curr_x(x_pos), .curr_y(y_pos), .left_x(START_X), .top_y(START_Y),
        .scale(SCALE), .digit(Q), .isDigit(isQ)
    );
    signed_dig_disp q_num ( // capped at 5 questions version
        .clk(clk_25M), .curr_x(x_pos), .curr_y(y_pos), .left_x(START_X + X_OFFSET), .top_y(START_Y),
        .scale(SCALE), .digit(question_num + 1), .isDigit(isQuestionNumber)
    );

    localparam [6:0] END_X = 7'd86; // 2 pix gap after 86 + 8 (86 included)
    localparam signed [4:0] five = 5'd5;

    // assume that score can't be 10, idk. I'll go to results screen first I think. 
    wire isCurrentScore; wire isSlash; wire isTotalScore;
    signed_dig_disp curr_score (
        .clk(clk_25M), .curr_x(x_pos), .curr_y(y_pos), .left_x(END_X - X_OFFSET * 2), .top_y(START_Y),
        .scale(SCALE), .digit(score), .isDigit(isCurrentScore)
    );
    signed_dig_disp slesh (
        .clk(clk_25M), .curr_x(x_pos), .curr_y(y_pos), .left_x(END_X - X_OFFSET), .top_y(START_Y),
        .scale(SCALE), .digit(slash), .isDigit(isSlash)
    );
    signed_dig_disp total_score (
        .clk(clk_25M), .curr_x(x_pos), .curr_y(y_pos), .left_x(END_X), .top_y(START_Y),
        .scale(SCALE), .digit(five), .isDigit(isTotalScore)
    );

    assign isHeader = isQ || isQuestionNumber || isCurrentScore || isSlash || isTotalScore;

endmodule
