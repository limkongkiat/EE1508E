`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2024 13:37:51
// Design Name: 
// Module Name: buttons_display
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


module buttons_display(
    input clk_25M,
    input [6:0] x_pos, input [5:0] y_pos,
    output isTrueButton, output isFalseButton
    );

    wire isWordTrue; wire isWordFalse; // driven below by modules
    reg isTrueButtonBorder = 0; reg isFalseButtonBorder = 0; // driven in alw block below
    assign isTrueButton = isWordTrue || isTrueButtonBorder;
    assign isFalseButton = isWordFalse || isFalseButtonBorder;

    // need to reverse because little endian
    function [24:0] reverse_bits(input [24:0] in);
        integer i;
        begin
            for (i = 0; i < 5; i = i + 1) begin
                reverse_bits[5 * i +: 5] = in[5 * (4 - i) +: 5];
            end
        end
    endfunction

    localparam [24:0] true_idx  = reverse_bits({5'd1, 5'd2, 5'd3, 5'd4, 5'd0});  // "TRUE "
    localparam [24:0] false_idx = reverse_bits({5'd5, 5'd6, 5'd7, 5'd8, 5'd4});  // "FALSE"

    localparam [5:0] Y_OFFSET       = 54;
    localparam [6:0] TRUE_X_OFFSET  = 3;
    localparam [6:0] FALSE_X_OFFSET = 53;

    button_word_display true (
        .clk_25M(clk_25M),
        .start_x(TRUE_X_OFFSET),
        .start_y(Y_OFFSET),
        .x_pos(x_pos), .y_pos(y_pos),
        .sentence(true_idx),
        .isLetter(isWordTrue)
    );

    button_word_display false (
        .clk_25M(clk_25M),
        .start_x(FALSE_X_OFFSET),
        .start_y(Y_OFFSET),
        .x_pos(x_pos), .y_pos(y_pos),
        .sentence(false_idx),
        .isLetter(isWordFalse)
    );

    localparam [15:0] GREY  = 16'b11111_111111_11111;
    localparam [15:0] GREEN = 16'b00000_111111_00000;
    localparam [15:0] RED   = 16'b11111_000000_00000;

    always @ (posedge clk_25M) begin
        if ((y_pos == 50 && x_pos <= 46) || (x_pos == 46 && y_pos > 50)
            || (y_pos == 49 && x_pos == 95)) begin
            isTrueButtonBorder = 1;
            isFalseButtonBorder = 0;
        end else if ((y_pos == 50 && x_pos >= 47 && x_pos < 95) || (x_pos == 47 && y_pos > 50)) begin
            isTrueButtonBorder = 0;
            isFalseButtonBorder = 1;
        end else begin
            isTrueButtonBorder = 0;
            isFalseButtonBorder = 0;
        end
    end

endmodule
