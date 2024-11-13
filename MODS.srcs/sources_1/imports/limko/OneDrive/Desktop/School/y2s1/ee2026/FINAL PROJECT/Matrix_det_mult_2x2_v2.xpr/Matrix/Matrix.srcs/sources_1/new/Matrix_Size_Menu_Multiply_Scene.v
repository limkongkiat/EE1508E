`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2024 22:15:13
// Design Name: 
// Module Name: Matrix_Size_Menu_Multiply_Scene
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


module matrix_size_multiply_scene(input clk, input btnU_db, btnL_db, btnD_db, btnR_db, btnC_db, input [12:0] pix_index,
    input active_flag, input [1:0] row_restriction,
    output reg [15:0] oled_colour, output exit_flag, output [1:0] matrix_row, output [1:0] matrix_col);

    wire clk_25MHz;
    flexi_clock clk_25M(clk, 1, clk_25MHz);

    wire [6:0] x_coord;
    wire [5:0] y_coord;
    index_to_coordinates i2c(pix_index, x_coord, y_coord);

    wire [15:0] words_background;
    BRAM_mult_size (.clk(clk), .addr(pix_index), .read_write(0), .data_in(0), .data_out(words_background));
    wire [15:0] words_r1_background;
    BRAM_mult_size_r1 (.clk(clk), .addr(pix_index), .read_write(0), .data_in(0), .data_out(words_r1_background));
    wire [15:0] words_r2_background;
    BRAM_mult_size_r2 (.clk(clk), .addr(pix_index), .read_write(0), .data_in(0), .data_out(words_r2_background));

    wire [15:0] sel_colour;
    wire [1:0] grid_row, grid_col;


    matrix_size_selector multiply_size_sel(.clk(clk),
        .btnU_db(btnU_db), .btnL_db(btnL_db), .btnD_db(btnD_db), .btnR_db(btnR_db), .btnC_db(btnC_db),
        .active_flag(active_flag), .row_restriction(row_restriction), .number_of_rows(2), .number_of_cols(2),
        .row(grid_row), .col(grid_col), .complete_selection(exit_flag));
    matrix_size_selector_box multiply_size_sel_box(.clk(clk), .x_coord(x_coord), .y_coord(y_coord),
        .row(grid_row), .col(grid_col), .rgb(sel_colour));

    assign matrix_row = grid_row + 1;
    assign matrix_col = grid_col + 1;

    always @ (posedge clk_25MHz) begin
        if (active_flag) begin
            if (sel_colour != 0) begin
                oled_colour <= sel_colour;
            end
            else begin
                case(row_restriction)
                    0: begin
                        oled_colour <= words_background;
                    end
                    1: begin
                        oled_colour <= words_r1_background;
                    end
                    2: begin
                        oled_colour <= words_r2_background;
                    end
                endcase
            end
        end
    end

endmodule
