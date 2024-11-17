`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2024 10:58:49
// Design Name: 
// Module Name: Matrix_Output_Scene
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


module matrix_output_scene(input clk, btnC_db, input [12:0] pix_index,
    input active_flag, [1:0] number_of_rows, [1:0] number_of_cols,
    input signed [4:0] num11, signed [4:0] num12, signed [4:0] num13,
    signed [4:0] num21, signed [4:0] num22, signed [4:0] num23,
    signed [4:0] num31, signed [4:0] num32, signed [4:0] num33, 
    signed [4:0] num41, signed [4:0] num42, signed [4:0] num43,
    signed [4:0] num51, signed [4:0] num52, signed [4:0] num53,
    signed [4:0] num61, signed [4:0] num62, signed [4:0] num63,
    signed [4:0] num71, signed [4:0] num72, signed [4:0] num73,
    signed [4:0] num81, signed [4:0] num82, signed [4:0] num83,
    signed [4:0] num91, signed [4:0] num92, signed [4:0] num93,
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
    wire signed [4:0] output_num [7:0][2:0];

    assign output_num[0][0] = number_of_cols > 1 ? num21 : 15;
    assign output_num[0][1] = number_of_cols > 1 ? num22 : 15;
    assign output_num[0][2] = number_of_cols > 1 ? num23 : 15;
    assign output_num[1][0] = number_of_cols > 2 ? num31 : 15;
    assign output_num[1][1] = number_of_cols > 2 ? num32 : 15;
    assign output_num[1][2] = number_of_cols > 2 ? num33 : 15;
    assign output_num[2][0] = number_of_rows > 1 ? num41 : 15;
    assign output_num[2][1] = number_of_rows > 1 ? num42 : 15;
    assign output_num[2][2] = number_of_rows > 1 ? num43 : 15;
    assign output_num[3][0] = (number_of_rows > 1 && number_of_cols > 1) ? num51 : 15;
    assign output_num[3][1] = (number_of_rows > 1 && number_of_cols > 1) ? num52 : 15;
    assign output_num[3][2] = (number_of_rows > 1 && number_of_cols > 1) ? num53 : 15;
    assign output_num[4][0] = (number_of_rows > 1 && number_of_cols > 2) ? num61 : 15;
    assign output_num[4][1] = (number_of_rows > 1 && number_of_cols > 2) ? num62 : 15;
    assign output_num[4][2] = (number_of_rows > 1 && number_of_cols > 2) ? num63 : 15;
    assign output_num[5][0] = number_of_rows > 2 ? num71 : 15;
    assign output_num[5][1] = number_of_rows > 2 ? num72 : 15;
    assign output_num[5][2] = number_of_rows > 2 ? num73 : 15;
    assign output_num[6][0] = (number_of_rows > 2 && number_of_cols > 1) ? num81 : 15;
    assign output_num[6][1] = (number_of_rows > 2 && number_of_cols > 1) ? num82 : 15;
    assign output_num[6][2] = (number_of_rows > 2 && number_of_cols > 1) ? num83 : 15;
    assign output_num[7][0] = (number_of_rows > 2 && number_of_cols > 2) ? num91 : 15;
    assign output_num[7][1] = (number_of_rows > 2 && number_of_cols > 2) ? num92 : 15;
    assign output_num[7][2] = (number_of_rows > 2 && number_of_cols > 2) ? num93 : 15;

    wire bracket_colour, matrix_colour, box_colour;
    matrix_output_disp output_disp(.clk(clk), .x_coord(x_coord), .y_coord(y_coord),
        .number_of_rows(number_of_rows), .number_of_cols(number_of_cols),
        .num11(num11), .num12(num12), .num13(num13),
        .num21(output_num[0][0]), .num22(output_num[0][1]), .num23(output_num[0][2]),
        .num31(output_num[1][0]), .num32(output_num[1][1]), .num33(output_num[1][2]),
        .num41(output_num[2][0]), .num42(output_num[2][1]), .num43(output_num[2][2]),
        .num51(output_num[3][0]), .num52(output_num[3][1]), .num53(output_num[3][2]),
        .num61(output_num[4][0]), .num62(output_num[4][1]), .num63(output_num[4][2]),
        .num71(output_num[5][0]), .num72(output_num[5][1]), .num73(output_num[5][2]),
        .num81(output_num[6][0]), .num82(output_num[6][1]), .num83(output_num[6][2]),
        .num91(output_num[7][0]), .num92(output_num[7][1]), .num93(output_num[7][2]),
        .is_matrix(matrix_colour), .is_bracket(bracket_colour));

    output_selector output_sel(.clk(clk), .btnC_db(btnC_db),
        .active_flag(active_flag), .complete_selection(exit_flag));
    
    output_selector_box output_sel_box(.clk(clk), .x_coord(x_coord), .y_coord(y_coord),
        .active_flag(active_flag), .is_box(box_colour));

    always @ (posedge clk_25MHz) begin
        if (active_flag) begin
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
    end

endmodule
