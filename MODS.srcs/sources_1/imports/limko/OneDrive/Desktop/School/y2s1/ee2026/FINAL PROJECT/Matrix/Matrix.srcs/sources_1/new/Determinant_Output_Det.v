`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2024 10:55:51
// Design Name: 
// Module Name: Determinant_Output_Det
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


module determinant_output_det(input clk, [6:0] x_coord, [5:0] y_coord, 
    [3:0] num1, num2, num3, num4, input polarity,
    output is_det);

    parameter [5:0] TOP_OFFSET = 28;
    parameter [6:0] LEFT_OFFSET = 18;
    parameter [6:0] DIGIT_LENGTH = 12;

    wire [3:0] num [5:0];
    assign num[0] = polarity ? 10 : 15;
    assign num[1] = num1;
    assign num[2] = num2;
    assign num[3] = num3;
    assign num[4] = num4;

    // wire signed [4:0] num [4:0];
    // assign num[0] = num1;
    // assign num[1] = num2;
    // assign num[2] = num3;
    // assign num[3] = num4;
    // assign num[4] = num5;

    wire [5:0] is_num;

    genvar i;
    generate
        for (i = 0; i < 5; i = i + 1) begin: digits_block
            // signed_dig_disp disp_i(
            // .clk(clk), .curr_x(x_coord), .curr_y(y_coord), 
            // .left_x(LEFT_OFFSET + i * DIGIT_LENGTH), .top_y(TOP_OFFSET),
            // .scale(2), .digit(num[i]), .isDigit(is_num[i])
            // );
            display_number_5x5(
            .clk(clk), .x_coord(x_coord), .y_coord(y_coord),
            .x_offset(LEFT_OFFSET + i * DIGIT_LENGTH), .y_offset(TOP_OFFSET),
            .scale(2), .number(num[i]), .is_coloured(is_num[i])
            );
        end
    endgenerate

    assign is_det = (is_num != 0);

endmodule
