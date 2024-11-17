`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2024 14:25:29
// Design Name: 
// Module Name: numpad_scene
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


module numpad_scene(input clk, input btnU_db, btnL_db, btnD_db, btnR_db, btnC_db, input [12:0] pix_index,
    input active_flag, input signed [4:0] prv_num,
    output reg [15:0] oled_colour, output exit_flag, output signed [4:0] number);

    parameter [15:0] BLACK = 0;
    parameter [15:0] GREEN = 16'b00000_111111_00000;
    parameter [15:0] LIGHT_GREEN = 16'b10000_111111_10000;
    
    parameter [6:0] LINE_LENGTH = 44;
    parameter [5:0] LINE_HEIGHT = 59;
    parameter [6:0] LEFT_OFFSET = 0;
    parameter [5:0] TOP_OFFSET = 2;
    parameter [5:0] BOTTOM_OFFSET = 3;
    parameter [6:0] BLANK_HEIGHT = 14;
    parameter [5:0] BLANK_LENGTH = 14;

    wire clk_50MHz;
    flexi_clock clk_50M(clk, 0, clk_50MHz);

    wire [6:0] x_coord;
    wire [5:0] y_coord;
    index_to_coordinates i2c(pix_index, x_coord, y_coord);

    wire [15:0] numpad_background;
    BRAM_numpad np (.clk(clk), .addr(pix_index), .read_write(0), .data_in(0), .data_out(numpad_background));
    

    wire [15:0] char_colour, sel_colour;
    wire [1:0] grid_row, grid_col;

    numpad_right_num np_right_num(.clk(clk), .x_coord(x_coord), .y_coord(y_coord),
        .number(number), .rgb(char_colour));
    numpad_selector np_sel(.clk(clk),
        .btnU_db(btnU_db), .btnL_db(btnL_db), .btnD_db(btnD_db), .btnR_db(btnR_db), .btnC_db(btnC_db),
        .prv_num(prv_num), .active_flag(active_flag),
        .row(grid_row), .col(grid_col),
        .selected_num(number), .complete_selection(exit_flag));
    numpad_selector_box np_sel_box(.clk(clk), .x_coord(x_coord), .y_coord(y_coord), .row(grid_row), .col(grid_col),
        .rgb(sel_colour));

    always @ (posedge clk_50MHz) begin
        if (active_flag) begin
            if (char_colour != 0) begin
                oled_colour <= char_colour;
            end
            else if (sel_colour != 0) begin
                oled_colour <= sel_colour;
            end
            else begin
                oled_colour <= numpad_background;
            end
        end
    end

endmodule
