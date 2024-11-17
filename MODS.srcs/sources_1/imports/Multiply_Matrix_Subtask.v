`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2024 21:18:05
// Design Name: 
// Module Name: Multiply_Matrix_Subtask
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


module multiply_matrix_subtask(input clk, input btnU_db, btnL_db, btnD_db, btnR_db, btnC_db, input [12:0] pix_index,
    input active_flag,
    output reg [15:0] oled_colour, output reg exit_flag);

    wire clk_1kHz, clk_25MHz;
    
    flexi_clock clk_1k(clk, 49_999, clk_1kHz);
    flexi_clock clk_25M(clk, 1, clk_25MHz);

    reg [2:0] state = 0; // output, input2, size2, input1, size1
    reg size_active = 0, input_active = 0, output_active = 0;
    wire size_exit, input_exit, output_exit;

    wire signed [4:0] num [8:0];
    reg signed [4:0] m1_num [8:0]; // numbers from 1st matrix
    reg signed [4:0] m2_num [8:0]; // numbers from 2nd matrix
    wire signed [8:0] m3_num [8:0]; // numbers from result matrix
    wire signed [4:0] output_num [8:0][2:0]; // output matrix

    reg [1:0] row_restriction = 0;
    wire [1:0] matrix_row, matrix_col;
    reg [1:0] number_of_rows, number_of_cols;
    reg [1:0] m1_row = 0, m1_col = 0, m2_row = 0, m2_col = 0; // actual number of rows and cols for matrix 1 & 2
    

    wire [15:0] size_colour, input_colour, output_colour;

    matrix_size_multiply_scene multiply_size_scene(.clk(clk),
        .btnU_db(btnU_db), .btnL_db(btnL_db), .btnD_db(btnD_db), .btnR_db(btnR_db), .btnC_db(btnC_db),
        .pix_index(pix_index), .active_flag(size_active), .row_restriction(row_restriction),
        .oled_colour(size_colour), .exit_flag(size_exit),
        .matrix_row(matrix_row), .matrix_col(matrix_col));

    matrix_input_scene multiply_input_scene(.clk(clk),
        .btnU_db(btnU_db), .btnL_db(btnL_db), .btnD_db(btnD_db), .btnR_db(btnR_db), .btnC_db(btnC_db),
        .pix_index(pix_index), .active_flag(input_active),
        .number_of_rows(number_of_rows), .number_of_cols(number_of_cols),
        .num1(num[0]), .num2(num[1]), .num3(num[2]), .num4(num[3]), .num5(num[4]),
        .num6(num[5]), .num7(num[6]), .num8(num[7]), .num9(num[8]), // connect to calculating logic
        .oled_colour(input_colour), .exit_flag(input_exit));
    
    multiplication_2x2_2x2 flex_mult (.clk(clk), .a11(m1_num[0]), .a12(m1_num[1]), .a21(m1_num[3]), .a22(m1_num[4]),
                                        .b11(m2_num[0]), .b12(m2_num[1]), .b21(m2_num[3]), .b22(m2_num[4]),
                                        .m1_rows(m1_row), .m1_cols(m1_col), .m2_rows(m2_row), .m2_cols(m2_col),
                                        .c11(m3_num[0]), .c12(m3_num[1]), .c21(m3_num[3]), .c22(m3_num[4]));
        
    process_result process_c11(.result(m3_num[0]), .result_hundreds(output_num[0][0]), .result_tens(output_num[0][1]), .result_ones(output_num[0][2]));
    process_result process_c12(.result(m3_num[1]), .result_hundreds(output_num[1][0]), .result_tens(output_num[1][1]), .result_ones(output_num[1][2]));
    process_result process_c21(.result(m3_num[3]), .result_hundreds(output_num[3][0]), .result_tens(output_num[3][1]), .result_ones(output_num[3][2]));
    process_result process_c22(.result(m3_num[4]), .result_hundreds(output_num[4][0]), .result_tens(output_num[4][1]), .result_ones(output_num[4][2]));

    matrix_output_scene multiply_output_scene(.clk(clk), .btnC_db(btnC_db), .pix_index(pix_index),
        .active_flag(output_active), .number_of_rows(m1_row), .number_of_cols(m2_col),
        .num11(output_num[0][0]), .num12(output_num[0][1]), .num13(output_num[0][2]),
        .num21(output_num[1][0]), .num22(output_num[1][1]), .num23(output_num[1][2]),
        .num31(output_num[2][0]), .num32(output_num[2][1]), .num33(output_num[2][2]),
        .num41(output_num[3][0]), .num42(output_num[3][1]), .num43(output_num[3][2]),
        .num51(output_num[4][0]), .num52(output_num[4][1]), .num53(output_num[4][2]),
        .num61(output_num[5][0]), .num62(output_num[5][1]), .num63(output_num[5][2]),
        .num71(output_num[6][0]), .num72(output_num[6][1]), .num73(output_num[6][2]),
        .num81(output_num[7][0]), .num82(output_num[7][1]), .num83(output_num[7][2]),
        .num91(output_num[8][0]), .num92(output_num[8][1]), .num93(output_num[8][2]),
        .oled_colour(output_colour), .exit_flag(output_exit));
    
    integer i;
    always @ (posedge clk_25MHz) begin
        if (exit_flag) begin
            exit_flag <= 0;
        end
        if (!active_flag) begin
            state <= 0;
            row_restriction <= 0;
        end
        case(state)
            3'b000: begin
                if (active_flag) begin
                    state <= 3'b001;
                end
                row_restriction <= 0;
                size_active <= 0;
                input_active <= 0;
                output_active <= 0;
            end
            3'b001: begin
                size_active <= 1;
                oled_colour <= size_colour;
                if (size_exit) begin
                    size_active <= 0;
                    m1_row <= matrix_row;
                    m1_col <= matrix_col;
                    number_of_rows <= matrix_row;
                    number_of_cols <= matrix_col;
                    row_restriction <= matrix_col;
                    for (i = 0; i < 9; i = i + 1) begin
                    m1_num[i] <= 0;
                    m2_num[i] <= 0;
                    end
                    state <= 3'b010;
                end
            end
            3'b010: begin
                input_active <= 1;
                oled_colour <= input_colour;
                if (input_exit) begin
                    input_active <= 0;
                    for (i = 0; i < 9; i = i + 1) begin
                        m1_num[i] <= num[i];
                    end
                    state <= 3'b011;
                end
            end
            3'b011: begin
                size_active <= 1;
                oled_colour <= size_colour;
                if (size_exit) begin
                    size_active <= 0;
                    m2_row <= matrix_row;
                    m2_col <= matrix_col;
                    number_of_rows <= matrix_row;
                    number_of_cols <= matrix_col;
                    state <= 3'b100;
                end
            end
            3'b100: begin
                input_active <= 1;
                oled_colour <= input_colour;
                if (input_exit) begin
                    input_active <= 0;
                    for (i = 0; i < 9; i = i + 1) begin
                        m2_num[i] <= num[i];
                    end
                    state <= 3'b101;
                end
            end
            3'b101: begin
                output_active <= 1;
                oled_colour <= output_colour;
                if (output_exit) begin
                    output_active <= 0;
                    state <= 3'b000;
                end
            end
            default: begin
                exit_flag <= 1;
            end
        endcase
    end
        
endmodule
