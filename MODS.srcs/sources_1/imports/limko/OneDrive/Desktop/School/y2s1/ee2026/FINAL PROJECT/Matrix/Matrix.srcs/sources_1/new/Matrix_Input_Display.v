`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2024 18:59:21
// Design Name: 
// Module Name: Matrix_Input_Display
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


module matrix_input_disp(
    input clk, [6:0] x_coord, [5:0] y_coord, 
    input [1:0] number_of_rows, [1:0] number_of_cols,
    input signed [4:0] num1, signed [4:0] num2, signed [4:0] num3,
    signed [4:0] num4, signed [4:0] num5, signed [4:0] num6,
    signed [4:0] num7, signed [4:0] num8, signed [4:0] num9,
    output is_matrix, is_bracket
    );

    parameter [5:0] BRACKET_TOP_OFFSET = 4;
    parameter [6:0] BRACKET_LEFT_OFFSET = 0;
    parameter [5:0] NUMBER_TOP_OFFSET = 8;
    parameter [6:0] NUMBER_LEFT_OFFSET = 8;
    parameter [5:0] OK_TOP_OFFSET = 42;
    parameter [6:0] OK_LEFT_OFFSET = 84;

    parameter [5:0] ROW_HEIGHT = 12;
    parameter [5:0] ROW_SPACING = 6;
    parameter [6:0] COL_LENGTH = 16;
    parameter [6:0] COL_SPACING = 6;
    
    wire signed [4:0] num [8:0];
    assign num[0] = num1;
    assign num[1] = num2;
    assign num[2] = num3;
    assign num[3] = num4;
    assign num[4] = num5;
    assign num[5] = num6;
    assign num[6] = num7;
    assign num[7] = num8;
    assign num[8] = num9;
    
    wire clk_25MHz;
    flexi_clock clk_25M (clk, 1, clk_25MHz);

    wire is_bracket1;
    matrix_bracket b1(
        .clk_25MHz(clk_25MHz), .curr_x(x_coord), .curr_y(y_coord), 
        .top(BRACKET_TOP_OFFSET + (3 - number_of_rows) * ((ROW_HEIGHT + ROW_SPACING) / 2)),
        .bottom(BRACKET_TOP_OFFSET + (3 - number_of_rows) * ((ROW_HEIGHT + ROW_SPACING) / 2) +
            ROW_HEIGHT * number_of_rows + ROW_SPACING * (number_of_rows - 1) + 5),
        .left(BRACKET_LEFT_OFFSET + ((COL_LENGTH + COL_SPACING) / 2) * (3 - number_of_cols)), .isOpen(1),
        .isBracket(is_bracket1)
        );
        
    wire is_bracket2;
    matrix_bracket b2(
        .clk_25MHz(clk_25MHz), .curr_x(x_coord), .curr_y(y_coord), 
        .top(BRACKET_TOP_OFFSET + (3 - number_of_rows) * ((ROW_HEIGHT + ROW_SPACING) / 2)),
        .bottom(BRACKET_TOP_OFFSET + (3 - number_of_rows) * ((ROW_HEIGHT + ROW_SPACING) / 2) +
            ROW_HEIGHT * number_of_rows + ROW_SPACING * (number_of_rows - 1) + 5),
        .left(BRACKET_LEFT_OFFSET + ((COL_LENGTH + COL_SPACING) / 2) * (3 - number_of_cols) +
            COL_LENGTH * number_of_cols + COL_SPACING * (number_of_cols - 1) + (NUMBER_LEFT_OFFSET - 2) * 2),
        .isOpen(0), .isBracket(is_bracket2)
        );
    
    wire [8:0] is_num;
    
    genvar i;
    generate
        for (i = 0; i < 9; i = i + 1) begin: digits_block
            signed_dig_disp disp_i(
            .clk(clk), .curr_x(x_coord), .curr_y(y_coord), 
            .left_x(NUMBER_LEFT_OFFSET + (3 - number_of_cols) * ((COL_LENGTH + COL_SPACING) / 2) + (i % 3) * (COL_LENGTH + COL_SPACING)), 
            .top_y(NUMBER_TOP_OFFSET + (3 - number_of_rows) * ((ROW_HEIGHT + ROW_SPACING) / 2) + (i / 3) * (ROW_HEIGHT + ROW_SPACING)),
            .scale(2), .digit(num[i]), .isDigit(is_num[i])
            );
        end
    endgenerate

    // wire colour_O, colour_K;
    // letter_display char_O(.clk_25M(clk_25MHz), .left_x(OK_LEFT_OFFSET), .top_y(OK_TOP_OFFSET), .x_pos(x_coord), .y_pos(y_coord),
    //     .scale(1), .letter(15), .isLetter(colour_O));
    // letter_display char_K(.clk_25M(clk_25MHz), .left_x(OK_LEFT_OFFSET + 5), .top_y(OK_TOP_OFFSET), .x_pos(x_coord), .y_pos(y_coord),
    //     .scale(1), .letter(11), .isLetter(colour_K));
    
    assign is_matrix = (is_num != 0) ? 1 : 0;
    assign is_bracket = (is_bracket1 || is_bracket2) ? 1 : 0;

endmodule
