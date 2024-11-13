`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 11:35:29
// Design Name: 
// Module Name: matrix_size_det_scene
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


module matrix_size_det_scene(input clk, input btnU_db, btnL_db, btnD_db, btnR_db, btnC_db, input [12:0] pix_index,
    input active_flag,
    output reg [15:0] oled_colour, output exit_flag, output [1:0] matrix_row);

    wire clk_25MHz;
    flexi_clock clk_25M(clk, 1, clk_25MHz);

    wire [6:0] x_coord;
    wire [5:0] y_coord;
    index_to_coordinates i2c(pix_index, x_coord, y_coord);

    wire [15:0] words_background;
    BRAM_Det_Size_select (.clk(clk), .addr(pix_index), .read_write(0), .data_in(0), .data_out(words_background));

    wire [15:0] sel_colour;
    wire [1:0] grid_row, grid_col;
    matrix_size_selector size_sel(.clk(clk),
        .btnU_db(btnU_db), .btnL_db(btnL_db), .btnD_db(btnD_db), .btnR_db(btnR_db), .btnC_db(btnC_db),
        .active_flag(active_flag), .row_restriction(0), .number_of_rows(1), .number_of_cols(2),
        .row(grid_row), .col(grid_col),
        .complete_selection(exit_flag));
    matrix_size_selector_box size_sel_box(.clk(clk), .x_coord(x_coord), .y_coord(y_coord),
        .row(grid_row), .col(grid_col), .rgb(sel_colour));

    assign matrix_row = (grid_col == 0) ? 2 : 3;

    always @ (posedge clk_25MHz) begin
        if (active_flag) begin
            if (sel_colour != 0) begin
                oled_colour <= sel_colour;
            end
            else begin
                oled_colour <= words_background;
            end
        end
    end

endmodule
