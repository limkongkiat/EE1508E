`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2024 10:15:49
// Design Name: 
// Module Name: numpad_right_num
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


module numpad_right_num(input clk, [6:0] x_coord, [5:0] y_coord, signed [4:0] number,
    output [15:0] rgb);

    parameter [15:0] BLACK = 0;
    parameter [15:0] LIGHT_GREEN = 16'b10000_111111_10000;

    parameter [6:0] NUM_X = 54;
    parameter [5:0] NUM_Y = 22;

    // wire clk_50MHz;
    // flexi_clock clk_50M(clk, 0, clk_50MHz);

    wire signed [4:0] num [18:0];
    generate
        genvar j;
        for (j = 0; j <= 18; j = j + 1) begin : positive_values
            assign num[j] = j - 9; // -9 to index 0, 9 to index 18
        end
    endgenerate

    wire [18:0] colour_num;

    genvar i;
    generate
        for (i = 0; i < 19; i = i + 1) begin: instantiate_digits
            signed_dig_disp num_disp(.clk(clk), .curr_x(x_coord), .curr_y(y_coord), .left_x(NUM_X), .top_y(NUM_Y),
                .digit(num[i]), .scale(4), .isDigit(colour_num[i]));
        end
    endgenerate

    assign rgb = colour_num[number + 9] != 0 ? LIGHT_GREEN : BLACK;

endmodule
