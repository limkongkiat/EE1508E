`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.10.2024 00:21:39
// Design Name: 
// Module Name: sp_matrix_main
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


module sp_matrix_main(
    input clk, clk_6p25M, [12:0] pix_idx, [6:0] curr_x, [5:0] curr_y, 
    input pb_up, pb_down, pb_left, pb_right,
    input isActive,
    output reg [15:0] oled_colour = 0
    );

    wire clk_1k;
    flexi_clock clk_1kHz (.basys_clk(clk), .my_m_value(49_999), .my_clk(clk_1k));
    wire clk_10k;
    flexi_clock clk_10kHz (.basys_clk(clk), .my_m_value(4_999), .my_clk(clk_10k));
    wire MHz25;
    flexi_clock clk_25MHz (.basys_clk(clk), .my_m_value(1), .my_clk(MHz25));

    wire [15:0] oled_basic;
    wire [15:0] oled_square;
    wire [15:0] oled_diagonal;
    wire [2:0] status_collation;
    
    // wire pb_down, pb_up, pb_left, pb_right;
    // switch_debouncing debounce1(.clk_1k(clk_1k), .pb(BtnD), .press_detected(pb_down));
    // switch_debouncing debounce2(.clk_1k(clk_1k), .pb(BtnU), .press_detected(pb_up));
    // switch_debouncing debounce3(.clk_1k(clk_1k), .pb(BtnL), .press_detected(pb_left));
    // switch_debouncing debounce4(.clk_1k(clk_1k), .pb(BtnR), .press_detected(pb_right));
    
    basics_matrix_page bmp(.clk(clk), .clk_6p25M(clk_6p25M), .pix_idx(pix_idx), .curr_x(curr_x), .curr_y(curr_y), 
        .pb_up(pb_up), .pb_down(pb_down), .pb_left(pb_left), .pb_right(pb_right), .isActive(isActive),
        .oled_colour(oled_basic), .status(status_collation[0]));

    sq_matrix_page smp(.clk(clk), .clk_6p25M(clk_6p25M), .pix_idx(pix_idx), .curr_x(curr_x), .curr_y(curr_y), 
       .pb_up(pb_up), .pb_down(pb_down), .pb_left(pb_left), .pb_right(pb_right), .isActive(isActive),
       .oled_colour(oled_square), .status(status_collation[1]));
           
    diagonal_matrix_page dmp(.clk(clk), .clk_6p25M(clk_6p25M), .pix_idx(pix_idx), .curr_x(curr_x), .curr_y(curr_y), 
       .pb_up(pb_up), .pb_down(pb_down), .pb_left(pb_left), .pb_right(pb_right), .isActive(isActive),
       .oled_colour(oled_diagonal), .status(status_collation[2])); 
          
    wire [2:0] page_select;

    always @ (posedge MHz25) begin
        if (page_select == 0)
            oled_colour <= oled_basic;
        else if (page_select == 1)
            oled_colour <= oled_square;
        else if (page_select == 2)
            oled_colour <= oled_diagonal;
        else
            oled_colour <= 0;
    end
    
    state_update_LR matrixStateUpdate (
        .clk_1k(clk_1k),
        .pb_left(pb_left), .pb_right(pb_right),
        .active_flag(status_collation == 0),
        .reset(isActive),
        .STATE_COUNT(3),
        .TIMER(0),
        .state(page_select)
    );

endmodule
