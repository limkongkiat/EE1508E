`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2024 16:00:37
// Design Name: 
// Module Name: Matrix_Input_Selector_Box
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


module matrix_input_selector_box(input clk, input [6:0] x_coord, [5:0] y_coord,
    input [1:0] row, [1:0] col,
    input [1:0] number_of_rows, [1:0] number_of_cols,
    output reg is_box);

    parameter [5:0] TOP_OFFSET = 8 - 2;
    parameter [6:0] LEFT_OFFSET = 8 - 2;
    parameter [5:0] ROW_HEIGHT = 12;
    parameter [5:0] ROW_SPACING = 6;
    parameter [6:0] COL_LENGTH = 16;
    parameter [6:0] COL_SPACING = 6;
    parameter [6:0] BOX_LENGTH = 16 + 4;
    parameter [5:0] BOX_HEIGHT = 12 - 2 + 4;

    parameter [5:0] OK_TOP_OFFSET = 56 - 2;
    parameter [6:0] OK_LEFT_OFFSET = 84 - 2;
    parameter [6:0] OK_BOX_LENGTH = 10 - 1 + 4;
    parameter [5:0] OK_BOX_HEIGHT = 5 + 4;

    wire clk_25MHz;
    flexi_clock clk_25M(clk, 1, clk_25MHz);

    always @ (posedge clk_25MHz) begin
        if (number_of_cols == col) begin
            if ((x_coord >= OK_LEFT_OFFSET && x_coord <= OK_LEFT_OFFSET + OK_BOX_LENGTH - 1) &&
                (y_coord == OK_TOP_OFFSET || y_coord == OK_TOP_OFFSET + OK_BOX_HEIGHT - 1)) begin
                is_box <= 1;
            end
            else if ((y_coord >= OK_TOP_OFFSET && y_coord < OK_TOP_OFFSET + OK_BOX_HEIGHT) &&
                (x_coord == OK_LEFT_OFFSET || x_coord == OK_LEFT_OFFSET + OK_BOX_LENGTH - 1)) begin
                is_box <= 1;
            end
            else begin
            is_box <= 0;
        end
        end
        else if ((x_coord >= LEFT_OFFSET + (3 - number_of_cols) * ((COL_LENGTH + COL_SPACING) / 2) + col * (COL_LENGTH + COL_SPACING) &&
            x_coord < LEFT_OFFSET + (3 - number_of_cols) * ((COL_LENGTH + COL_SPACING) / 2) + col * (COL_LENGTH + COL_SPACING) + BOX_LENGTH) &&
            (y_coord == TOP_OFFSET + (3 - number_of_rows) * ((ROW_HEIGHT + ROW_SPACING) / 2) + row * (ROW_HEIGHT + ROW_SPACING) ||
            y_coord == TOP_OFFSET + (3 - number_of_rows) * ((ROW_HEIGHT + ROW_SPACING) / 2) + row * (ROW_HEIGHT + ROW_SPACING) + BOX_HEIGHT - 1)) begin
            is_box <= 1;
        end
        else if ((y_coord >= TOP_OFFSET + (3 - number_of_rows) * ((ROW_HEIGHT + ROW_SPACING) / 2) + row * (ROW_HEIGHT + ROW_SPACING) &&
            y_coord < TOP_OFFSET + (3 - number_of_rows) * ((ROW_HEIGHT + ROW_SPACING) / 2) + row * (ROW_HEIGHT + ROW_SPACING) + BOX_HEIGHT) &&
            (x_coord == LEFT_OFFSET + (3 - number_of_cols) * ((COL_LENGTH + COL_SPACING) / 2) + col * (COL_LENGTH + COL_SPACING) ||
            x_coord == LEFT_OFFSET + (3 - number_of_cols) * ((COL_LENGTH + COL_SPACING) / 2) + col * (COL_LENGTH + COL_SPACING) + BOX_LENGTH - 1)) begin
            is_box <= 1;
        end
        else begin
            is_box <= 0;
        end
    end
endmodule