`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.10.2024 14:20:18
// Design Name: 
// Module Name: oled_driver
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


module oled_driver(
    input clk_25M,
    input active_flag,
    input [1:0] current_state,
    input isHeader, isTrueButton, isFalseButton,
    input [15:0] score_screen,
    input isCurrentScore,
    input [1:0] isHoverLeftRight, // 0: hover neither, 1: hover left, 2: hover right
    input [15:0] word_screen,
    input blink, input [15:0] judgement_screen,
    output reg [15:0] oled_colour
    );

    // please use this GOATED green colour
    localparam [15:0] LIGHT_GREEN = 16'b10000_111111_10000;

    localparam [15:0] WHITE = 16'b11111_111111_11111;
    localparam [15:0] BLACK = 16'b00000_000000_00000;
    localparam [15:0] GREY  = 16'b10000_100000_10000;
    localparam [15:0] GREEN = 16'b00000_111111_00000;
    localparam [15:0] RED   = 16'b11111_000000_00000;

    localparam [1:0] DISPLAY_QUESTION = 2'b00;
    localparam [1:0] DISPLAY_ANSWER = 2'b01;
    localparam [1:0] NEXT_QUESTION = 2'b10;
    localparam [1:0] RESULTS_SCREEN = 2'b11;

    // oled screen driver
    always @ (posedge clk_25M) begin
        if (active_flag) begin
            case (current_state)
                DISPLAY_ANSWER: begin
                    if (blink)
                        oled_colour <= judgement_screen;
                    else
                        oled_colour <= BLACK;
                end
                DISPLAY_QUESTION: begin
                    if (word_screen) // if there's words - ie, not black.
                        oled_colour <= word_screen;
                    else if (isHeader)
                        oled_colour <= LIGHT_GREEN;
                    else if (isTrueButton)
                        oled_colour <= isHoverLeftRight == 2'b01 ? GREEN : GREY;
                    else if (isFalseButton)
                        oled_colour <= isHoverLeftRight == 2'b10 ? RED : GREY;
                    else
                        oled_colour <= BLACK;
                end
                RESULTS_SCREEN: begin
                    if (score_screen)
                        oled_colour <= score_screen;
                    else if (isCurrentScore)
                        oled_colour <= GREEN;
                    else
                        oled_colour <= BLACK;
                end
            endcase
        end else begin
            oled_colour <= BLACK;
        end
    end

endmodule
