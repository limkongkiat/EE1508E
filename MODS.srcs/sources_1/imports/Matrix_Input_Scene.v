`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2024 16:00:37
// Design Name: 
// Module Name: Matrix_Input_Scene
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


module matrix_input_scene(input clk, btnU_db, btnL_db, btnD_db, btnR_db, btnC_db, input [12:0] pix_index,
    input active_flag, [1:0] number_of_rows, [1:0] number_of_cols,
    output reg signed [4:0] num1 = 0, reg signed [4:0] num2 = 0, reg signed [4:0] num3 = 0,
    reg signed [4:0] num4 = 0, reg signed [4:0] num5 = 0, reg signed [4:0] num6 = 0,
    reg signed [4:0] num7 = 0, reg signed [4:0] num8 = 0, reg signed [4:0] num9 = 0,
    output reg [15:0] oled_colour, output exit_flag);

    parameter [15:0] GREEN = 16'b00000_111111_00000;
    parameter [15:0] LIGHT_GREEN = 16'b10000_111111_10000;
    parameter [15:0] LIGHT_TURQOISE = 16'b00111_110111_11010;
    parameter [15:0] BLACK = 0;

    wire clk_25MHz;
    flexi_clock clk_25M(clk, 1, clk_25MHz);

    wire [6:0] x_coord;
    wire [5:0] y_coord;
    index_to_coordinates i2c(pix_index, x_coord, y_coord);

    wire [15:0] OK_background;
    BRAM_OK (.clk(clk), .addr(pix_index), .read_write(0), .data_in(0), .data_out(OK_background));

    wire signed [4:0] num [8:0];
    wire [1:0] row, col;
    wire bracket_colour, matrix_colour, box_colour;
    wire select_term;
    reg pause_sel = 0, run_once_flag = 0;

    matrix_input_disp input_disp(.clk(clk), .x_coord(x_coord), .y_coord(y_coord),
        .number_of_rows(number_of_rows), .number_of_cols(number_of_cols),
        .num1(num1), .num2(num2), .num3(num3), .num4(num4),  .num5(num5),
        .num6(num6), .num7(num7), .num8(num8), .num9(num9),
        .is_matrix(matrix_colour), .is_bracket(bracket_colour));
    
    matrix_input_selector input_sel(.clk(clk),
        .btnU_db(btnU_db), .btnL_db(btnL_db), .btnD_db(btnD_db), .btnR_db(btnR_db), .btnC_db(btnC_db),
        .active_flag(active_flag), .pause_flag(pause_sel),
        .number_of_rows(number_of_rows), .number_of_cols(number_of_cols),
        .row(row), .col(col), .complete_selection(exit_flag), .select_term(select_term));
    
    matrix_input_selector_box input_sel_box(.clk(clk), .x_coord(x_coord), .y_coord(y_coord), .row(row), .col(col),
        .number_of_rows(number_of_rows), .number_of_cols(number_of_cols),
        .is_box(box_colour));

    reg edit_number = 0;
    wire edit_complete;
    wire [15:0] numpad_colour;
    reg [4:0] prv_num = 0;
    wire signed [4:0] new_num;
    numpad_scene np_scene(.clk(clk), .btnU_db(btnU_db), .btnL_db(btnL_db), .btnD_db(btnD_db), .btnR_db(btnR_db), .btnC_db(btnC_db),
        .pix_index(pix_index), .active_flag(edit_number), .prv_num(prv_num),
        .oled_colour(numpad_colour), .exit_flag(edit_complete), .number(new_num));

    always @ (posedge clk_25MHz) begin
        if (!active_flag) begin
            run_once_flag <= 0;
            pause_sel <= 1;
        end
        else if (!run_once_flag) begin
            run_once_flag <= 1;
            num1 <= 0;
            if (number_of_cols > 1) begin
                num2 <= 0;
            end
            else begin
                num2 <= 15;
            end
            if (number_of_cols > 2) begin
                num3 <= 0;
            end
            else begin
                num3 <= 15;
            end
            if (number_of_rows > 1) begin
                num4 <= 0;
            end
            else begin
                num4 <= 15;
            end
            if (number_of_rows > 1 && number_of_cols > 1) begin
                num5 <= 0;
            end
            else begin
                num5 <= 15;
            end
            if (number_of_rows > 1 && number_of_cols > 2) begin
                num6 <= 0;
            end
            else begin
                num6 <= 15;
            end
            if (number_of_rows > 2) begin
                num7 <= 0;
            end
            else begin
                num7 <= 15;
            end
            if (number_of_rows > 2 && number_of_cols > 1) begin
                num8 <= 0;
            end
            else begin
                num8 <= 15;
            end
            if (number_of_rows > 2 && number_of_cols > 2) begin
                num9 <= 0;
            end
            else begin
                num9 <= 15;
            end
            pause_sel <= 0;
        end
        else if (row == 0 && col == 0) begin
            prv_num <= num1;
        end
        else if (row == 0 && col == 1) begin
            prv_num <= num2;
        end
        else if (row == 0 && col == 2) begin
            prv_num <= num3;
        end
        else if (row == 1 && col == 0) begin
            prv_num <= num4;
        end
        else if (row == 1 && col == 1) begin
            prv_num <= num5;
        end
        else if (row == 1 && col == 2) begin
            prv_num <= num6;
        end
        else if (row == 2 && col == 0) begin
            prv_num <= num7;
        end
        else if (row == 2 && col == 1) begin
            prv_num <= num8;
        end
        else if (row == 2 && col == 2) begin
            prv_num <= num9;
        end

        if (select_term) begin
            pause_sel <= 1;
            edit_number <= 1;
        end
        else if (edit_complete) begin
            edit_number <= 0;
            pause_sel <= 0;
            if (row == 0 && col == 0) begin
                num1 <= new_num;
            end
            else if (row == 0 && col == 1) begin
                num2 <= new_num;
            end
            else if (row == 0 && col == 2) begin
                num3 <= new_num;
            end
            else if (row == 1 && col == 0) begin
                num4 <= new_num;
            end
            else if (row == 1 && col == 1) begin
                num5 <= new_num;
            end
            else if (row == 1 && col == 2) begin
                num6 <= new_num;
            end
            else if (row == 2 && col == 0) begin
                num7 <= new_num;
            end
            else if (row == 2 && col == 1) begin
                num8 <= new_num;
            end
            else if (row == 2 && col == 2) begin
                num9 <= new_num;
            end
        end
    end

    always @ (posedge clk_25MHz) begin
        if (active_flag) begin
            if (!pause_sel) begin
                if (bracket_colour) begin
                    oled_colour <= GREEN;
                end
                else if (matrix_colour) begin
                    oled_colour <= LIGHT_GREEN;
                end
                else if (box_colour) begin
                    oled_colour <= LIGHT_TURQOISE;
                end
                else begin
                    oled_colour <= OK_background;
                end
            end            
            else if (edit_number) begin
                oled_colour <= numpad_colour;
            end
            else begin
                oled_colour <= BLACK;
            end
        end
    end


endmodule
