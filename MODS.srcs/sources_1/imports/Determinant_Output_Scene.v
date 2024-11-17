`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2024 10:55:51
// Design Name: 
// Module Name: Determinant_Output_Scene
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


module determinant_output_scene(input clk, btnC_db, active_flag, [12:0] pix_index,
    [3:0] digit1, digit2, digit3, digit4, input polarity,
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

    wire [15:0] words_background;
//    initial begin
//        $readmemh("Determinant_Output_Background.mem", words_background);
//    end
    BRAM_det_output_bg output_bg (.clk(clk), .addr(pix_index), .read_write(0), .data_in(0), .data_out(words_background));

    wire det_colour, box_colour;

    determinant_output_det det_output_det(.clk(clk), .x_coord(x_coord), .y_coord(y_coord), 
        .num1(digit1), .num2(digit2), .num3(digit3), .num4(digit4),
        .is_det(det_colour), .polarity(polarity));

    output_selector output_sel(.clk(clk), .btnC_db(btnC_db),
        .active_flag(active_flag), .complete_selection(exit_flag));
    
    output_selector_box output_sel_box(.clk(clk), .x_coord(x_coord), .y_coord(y_coord),
        .active_flag(active_flag), .is_box(box_colour));

    always @ (posedge clk_25MHz) begin
        if (active_flag) begin
            if (det_colour) begin
                oled_colour <= LIGHT_GREEN;
            end
            else if (box_colour) begin
                oled_colour <= LIGHT_TURQOISE;
            end
            else begin
                oled_colour <= words_background;
            end
        end
    end

endmodule
