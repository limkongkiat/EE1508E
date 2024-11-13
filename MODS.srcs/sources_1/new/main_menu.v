`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2024 09:40:17
// Design Name: 
// Module Name: main_menu
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


module main_menu(input clk, bullet_time, MHz6p25, [12:0] pix_idx, [6:0] curr_x, [5:0] curr_y, [4:0] arrowX, [5:0] arrowHeight,
    output reg [15:0] oled_main = 0);

    wire clk_1k;
    flexi_clock clk_1kHz (.basys_clk(clk), .my_m_value(49_999), .my_clk(clk_1k));

    wire matrix_bg_mem;
    BRAM_background m_bg (.clk(clk), .addr(pix_idx), .read_write(0), .data_in(0), .data_out(matrix_bg_mem));


    wire MHz25;
    flexi_clock clk_25MHz (.basys_clk(clk), .my_m_value(1), .my_clk(MHz25));
    
    wire rain_clk;
    assign rain_clk = bullet_time ? MHz25 : clk;
    
    wire [15:0] rain1_col;
    matrix_rain rain1 (.clk(rain_clk), .curr_x(curr_x), .curr_y(curr_y), .x_coord(2), .init_delay(15), .col(rain1_col));
    wire [15:0] rain2_col;
    matrix_rain rain2 (.clk(rain_clk), .curr_x(curr_x), .curr_y(curr_y), .x_coord(82), .init_delay(30), .col(rain2_col));
    wire [15:0] rain3_col;
    matrix_rain rain3 (.clk(rain_clk), .curr_x(curr_x), .curr_y(curr_y), .x_coord(72), .init_delay(23), .col(rain3_col));
    wire [15:0] rain4_col;
    matrix_rain rain4 (.clk(rain_clk), .curr_x(curr_x), .curr_y(curr_y), .x_coord(25), .init_delay(42), .col(rain4_col));
    wire [15:0] rain5_col;
    matrix_rain rain5 (.clk(rain_clk), .curr_x(curr_x), .curr_y(curr_y), .x_coord(40), .init_delay(19), .col(rain5_col));

    wire isArrow;
    selector_arrow sa (.MHz25(MHz25),
    .curr_x(curr_x), .curr_y(curr_y), 
    .left_x({2'b00,arrowX}), .top_y(arrowHeight), 
    .isArrow(isArrow));

    always @ (posedge MHz25) begin
        if (matrix_bg_mem != 0)
            oled_main <= 16'b0000_111111_00000;
        else if (isArrow)
            oled_main <= 16'b00111_110111_11010;
        else if (rain1_col != 0)
            oled_main <= rain1_col;
        else if (rain2_col != 0)
            oled_main <= rain2_col;
        else if (rain3_col != 0)
            oled_main <= rain3_col;            
        else if (rain4_col != 0)
            oled_main <= rain4_col;
        else if (rain5_col != 0)
            oled_main <= rain5_col; 
        else
            oled_main <= 0;
    end
    
endmodule
