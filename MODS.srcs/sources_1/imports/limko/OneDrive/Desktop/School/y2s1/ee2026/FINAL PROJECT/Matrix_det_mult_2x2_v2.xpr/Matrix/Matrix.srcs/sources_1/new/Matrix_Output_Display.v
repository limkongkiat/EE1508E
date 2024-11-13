`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2024 10:58:49
// Design Name: 
// Module Name: Matrix_Output_Display
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


module matrix_output_disp(
    input clk, [6:0] x_coord, [5:0] y_coord, 
    input [1:0] number_of_rows, [1:0] number_of_cols,
    input signed [4:0] num11, signed [4:0] num12, signed [4:0] num13,
    signed [4:0] num21, signed [4:0] num22, signed [4:0] num23,
    signed [4:0] num31, signed [4:0] num32, signed [4:0] num33, 
    signed [4:0] num41, signed [4:0] num42, signed [4:0] num43,
    signed [4:0] num51, signed [4:0] num52, signed [4:0] num53,
    signed [4:0] num61, signed [4:0] num62, signed [4:0] num63,
    signed [4:0] num71, signed [4:0] num72, signed [4:0] num73,
    signed [4:0] num81, signed [4:0] num82, signed [4:0] num83,
    signed [4:0] num91, signed [4:0] num92, signed [4:0] num93,
    output is_matrix, is_bracket
    );

    parameter [5:0] BRACKET_TOP_OFFSET = 4;
    parameter [6:0] BRACKET_LEFT_OFFSET = 1;
    parameter [5:0] NUMBER_TOP_OFFSET = 8;
    parameter [6:0] NUMBER_LEFT_OFFSET = 6;
    parameter [5:0] OK_TOP_OFFSET = 56;
    parameter [6:0] OK_LEFT_OFFSET = 84;

    parameter [5:0] ROW_HEIGHT = 6;
    parameter [5:0] ROW_SPACING = 12;
    parameter [6:0] COL_LENGTH = 24;
    parameter [6:0] COL_SPACING = 6;
    parameter [6:0] CHAR_SPACING = 8;
    
    wire signed [4:0] num [8:0][2:0];
    assign num[0][0] = num11;
    assign num[0][1] = num12;
    assign num[0][2] = num13;
    assign num[1][0] = num21;
    assign num[1][1] = num22;
    assign num[1][2] = num23;
    assign num[2][0] = num31;
    assign num[2][1] = num32;
    assign num[2][2] = num33;
    assign num[3][0] = num41;
    assign num[3][1] = num42;
    assign num[3][2] = num43;
    assign num[4][0] = num51;
    assign num[4][1] = num52;
    assign num[4][2] = num53;
    assign num[5][0] = num61;
    assign num[5][1] = num62;
    assign num[5][2] = num63;
    assign num[6][0] = num71;
    assign num[6][1] = num72;
    assign num[6][2] = num73;
    assign num[7][0] = num81;
    assign num[7][1] = num82;
    assign num[7][2] = num83;
    assign num[8][0] = num91;
    assign num[8][1] = num92;
    assign num[8][2] = num93;
    
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
            COL_LENGTH * number_of_cols + COL_SPACING * (number_of_cols - 1) +
            ((NUMBER_LEFT_OFFSET - BRACKET_LEFT_OFFSET - 2) * 2)),
        .isOpen(0), .isBracket(is_bracket2)
        );
    
    wire [26:0] is_num;
    
    genvar i, j;
    generate
        for (i = 0; i < 9; i = i + 1) begin: terms_block
            for (j = 0; j < 3; j = j + 1) begin: digits_block
                signed_dig_disp disp_i(
                .clk(clk), .curr_x(x_coord), .curr_y(y_coord), 
                .left_x(NUMBER_LEFT_OFFSET + (3 - number_of_cols) * ((COL_LENGTH + COL_SPACING) / 2) +
                    (i % 3) * (COL_LENGTH + COL_SPACING) + j * CHAR_SPACING), 
                .top_y(NUMBER_TOP_OFFSET + (3 - number_of_rows) * ((ROW_HEIGHT + ROW_SPACING) / 2) +
                    (i / 3) * (ROW_HEIGHT + ROW_SPACING)),
                .scale(1), .digit(num[i][j]), .isDigit(is_num[i * 3 + j])
                );
            end
        end
    endgenerate
    
    assign is_matrix = (is_num != 0) ? 1 : 0;
    assign is_bracket = (is_bracket1 || is_bracket2) ? 1 : 0;

endmodule
