`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 11:13:00
// Design Name: 
// Module Name: numpad_selector_box
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


module numpad_selector_box(input clk, input [6:0] x_coord, [5:0] y_coord, input [1:0] row, [1:0] col,
    output reg [15:0] rgb);

    parameter [5:0] TOP_OFFSET = 2;
    parameter [6:0] BLANK_LENGTH = 14;
    parameter [5:0] BLANK_HEIGHT = 14;
    parameter [6:0] BOX_LENGTH = 14;
    parameter [5:0] BOX_HEIGHT = 14;

    parameter [15:0] LIGHT_TURQOISE = 16'b00111_110111_11010;
    parameter [15:0] BLACK = 0;

    wire clk_50MHz;
    flexi_clock clk_50M(clk, 0, clk_50MHz);

    always @ (posedge clk_50MHz) begin
        if ((x_coord >= col * (BLANK_LENGTH + 1) && x_coord < col * (BLANK_LENGTH + 1) + BOX_LENGTH) &&
            (y_coord == TOP_OFFSET + row * (BLANK_HEIGHT + 1) ||
            y_coord == TOP_OFFSET + row * (BLANK_HEIGHT + 1) + BOX_HEIGHT - 1)) begin
            rgb <= LIGHT_TURQOISE;
        end
        else if ((y_coord >= TOP_OFFSET + row * (BLANK_HEIGHT + 1) &&
            y_coord < TOP_OFFSET + row * (BLANK_HEIGHT + 1) + BOX_HEIGHT) &&
            (x_coord == col * (BLANK_LENGTH + 1) || x_coord == col * (BLANK_LENGTH + 1) + BOX_LENGTH - 1)) begin
            rgb <= LIGHT_TURQOISE;
        end
        else begin
            rgb <= BLACK;
        end
    end
    
endmodule
