`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2024 21:18:05
// Design Name: 
// Module Name: Calculate_Determinant_Subtask
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


module calculate_determinant_subtask(input clk, input btnU_db, btnL_db, btnD_db, btnR_db, btnC_db, input [12:0] pix_index,
    input active_flag,
    output reg [15:0] oled_colour, output reg exit_flag, output [1:0] led, output pillFlag);

    wire clk_1kHz, clk_25MHz;
    
    flexi_clock clk_1k(clk, 49_999, clk_1kHz);
    flexi_clock clk_25M(clk, 1, clk_25MHz);

    reg [2:0] state = 0; // output, input, size
    reg size_active = 0, input_active = 0, output_active = 0;
    wire size_exit, input_exit, output_exit, pill_exit;

    wire signed [4:0] num [8:0];
    reg signed [4:0] m_num [8:0];
    wire [3:0] digit1, digit2, digit3, digit4, digit5;

    wire [15:0] size_colour, input_colour, output_colour, pill_colour;
    reg [1:0] number_of_rows;
    wire [1:0] matrix_row;

    wire signed [15:0] det_2x2, det_3x3, det;
    wire det_polarity;

    matrix_size_det_scene det_size_scene(.clk(clk),
        .btnU_db(btnU_db), .btnL_db(btnL_db), .btnD_db(btnD_db), .btnR_db(btnR_db), .btnC_db(btnC_db),
        .pix_index(pix_index), .active_flag(size_active),
        .oled_colour(size_colour), .exit_flag(size_exit), .matrix_row(matrix_row));

    matrix_input_scene det_input_scene(.clk(clk),
        .btnU_db(btnU_db), .btnL_db(btnL_db), .btnD_db(btnD_db), .btnR_db(btnR_db), .btnC_db(btnC_db),
        .pix_index(pix_index), .active_flag(input_active), .number_of_rows(number_of_rows), .number_of_cols(number_of_rows),
        .num1(num[0]), .num2(num[1]), .num3(num[2]), .num4(num[3]), .num5(num[4]),
        .num6(num[5]), .num7(num[6]), .num8(num[7]), .num9(num[8]), // connect to calculating logic
        .oled_colour(input_colour), .exit_flag(input_exit));

    determinant_2x2 det_2(.a11(num[0]), .a12(num[1]), .a21(num[3]), .a22(num[4]), .det(det_2x2));
    determinant_3x3 det_3(.a11(num[0]), .a12(num[1]), .a13(num[2]), .a21(num[3]), .a22(num[4]), .a23(num[5]),
        .a31(num[6]), .a32(num[7]), .a33(num[8]), .det(det_3x3));

    assign det = (number_of_rows == 3) ? det_3x3 : ((number_of_rows == 2) ? det_2x2 : 99999);

    parse_digits parse(.clk(clk), .reset(!output_active), .value(det),
    .digit_1(digit1), .digit_2(digit2), .digit_3(digit3), .digit_4(digit4), .polarity(det_polarity));

    determinant_output_scene det_output_scene(.clk(clk), .btnC_db(btnC_db), .pix_index(pix_index),
        .active_flag(output_active),
        .digit1(digit1), .digit2(digit2), .digit3(digit3), .digit4(digit4), .polarity(det_polarity),
        .oled_colour(output_colour), .exit_flag(output_exit));
    
    pill_scene pill_sc (.clk_25MHz(clk_25MHz), .clk_1k(clk_1kHz), .btnL_db(btnL_db), .btnR_db(btnR_db), .btnC_db(btnC_db), .pix_index(pix_index),
            .active_flag(state == 3'b100),
            .oled_colour(pill_colour), .exit_flag(pill_exit), .escapeMatrix(pillFlag));
            
    integer i;
    always @ (posedge clk_25MHz) begin
        if (exit_flag) begin
            exit_flag <= 0;
        end 
        if (!active_flag) begin
            state <= 0;
        end
        case(state)
            3'b000: begin
                if (active_flag) begin
                    state <= 3'b001;
                end
                size_active <= 0;
                input_active <= 0;
                output_active <= 0;
            end
            3'b001: begin
                size_active <= 1;
                oled_colour <= size_colour;
                if (size_exit) begin
                    number_of_rows <= matrix_row;
                    size_active <= 0;
                    state <= 3'b010;
                end
            end
            3'b010: begin
                input_active <= 1;
                oled_colour <= input_colour;
                if (input_exit) begin
                    for (i = 0; i < 9; i = i + 1) begin
                        m_num[i] <= num[i];
                    end
                    input_active <= 0;
                    state <= 3'b011;
                end
            end
            3'b011: begin
                output_active <= 1;
                oled_colour <= output_colour; 
                if (output_exit) begin
                    output_active <= 0;
                    state <= (det == 1999) ? 3'b100 : 3'b000;
                end
            end
            3'b100: begin
                oled_colour <= pill_colour;
                if (pill_exit)
                    state <= 3'b000;
            end
            default: begin
                exit_flag <= 1;
            end
        endcase
    end

    assign led = state;

endmodule
