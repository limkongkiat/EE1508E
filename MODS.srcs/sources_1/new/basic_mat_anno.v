`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.10.2024 00:00:25
// Design Name: 
// Module Name: basic_mat_anno
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


module basic_mat_anno(
    input clk_25MHz, [7:0] curr_x, [6:0] curr_y, 
    output reg isAnno = 0
    );

    wire [1:0] isLetters;
    signed_dig_disp two (
        .clk(clk_25MHz),
        .left_x(0),            // Increment by 6 for each letter
        .top_y(27),
        .curr_x(curr_x),
        .curr_y(curr_y),
        .scale(2),
        .digit(2),        // Letter from the unpacked array
        .isDigit(isLetters[1])
    );
    signed_dig_disp three (
        .clk(clk_25MHz),
        .left_x(40),            // Increment by 6 for each letter
        .top_y(53),
        .curr_x(curr_x),
        .curr_y(curr_y),
        .scale(2),
        .digit(3),        // Letter from the unpacked array
        .isDigit(isLetters[0])
    );

    reg isBars = 0;
    always @ (posedge clk_25MHz) begin
        if (curr_x >= 15 && curr_x <= 16 && curr_y >= 17 && curr_y <= 46)
            isBars <= 1;
        else if (curr_x >= 19 && curr_x <= 78 && curr_y >= 49 && curr_y <= 50)
            isBars <= 1;
        else
            isBars <= 0;
            
        isAnno <= (isBars || isLetters != 0) ? 1 : 0;
    end
endmodule
