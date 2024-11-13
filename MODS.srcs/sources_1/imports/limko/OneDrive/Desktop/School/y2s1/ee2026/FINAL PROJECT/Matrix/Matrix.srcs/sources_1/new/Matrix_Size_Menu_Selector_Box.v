`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 11:35:29
// Design Name: 
// Module Name: matrix_size_selector_box
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


module matrix_size_selector_box(input clk, input [6:0] x_coord, [5:0] y_coord, input [1:0] row, [1:0] col,
    output reg [15:0] rgb);

    parameter [5:0] TOP_OFFSET = 24 - 2;
    parameter [6:0] LEFT_OFFSET = 8;
    parameter [6:0] COL_LENGTH = 6 * 3;
    parameter [6:0] COL_SPACING = 12;
    parameter [5:0] ROW_HEIGHT = 5;
    parameter [5:0] ROW_SPACING = 8;
    parameter [6:0] BOX_LENGTH = 18 + 4 - 2;
    parameter [5:0] BOX_HEIGHT = 10 - 1;

    parameter [15:0] LIGHT_TURQOISE = 16'b00111_110111_11010;
    parameter [15:0] BLACK = 0;

    wire clk_25MHz;
    flexi_clock clk_25M(clk, 1, clk_25MHz);

    always @ (posedge clk_25MHz) begin
        if ((x_coord >= LEFT_OFFSET + col * (COL_LENGTH + COL_SPACING) &&
            x_coord < LEFT_OFFSET + col * (COL_LENGTH + COL_SPACING) + BOX_LENGTH) &&
            (y_coord == TOP_OFFSET + row * (ROW_HEIGHT + ROW_SPACING) ||
            y_coord == TOP_OFFSET + row * (ROW_HEIGHT + ROW_SPACING) + BOX_HEIGHT - 1)) begin
            rgb <= LIGHT_TURQOISE;
        end
        else if ((y_coord >= TOP_OFFSET + row * (ROW_HEIGHT + ROW_SPACING) &&
            y_coord < TOP_OFFSET + row * (ROW_HEIGHT + ROW_SPACING) + BOX_HEIGHT) &&
            (x_coord == LEFT_OFFSET + col * (COL_LENGTH + COL_SPACING) || x_coord == LEFT_OFFSET + col * (COL_LENGTH + COL_SPACING) + BOX_LENGTH - 1)) begin
            rgb <= LIGHT_TURQOISE;
        end
        else begin
            rgb <= BLACK;
        end
    end

endmodule
