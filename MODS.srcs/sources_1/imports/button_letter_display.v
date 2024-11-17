`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2024 16:12:20
// Design Name: 
// Module Name: button_letter_display
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


module button_letter_display(
    input clk_25M,
    input [6:0] left_x,
    input [5:0] top_y,
    input [6:0] x_pos,
    input [5:0] y_pos,
    input [4:0] letter,
    output reg isLetter = 0
    );
    
    reg [0:7] digit_ref [0:7];
    always @ (posedge clk_25M)
        begin
            case (letter)
                4'd0: begin // space
                    digit_ref[0] = 8'b00000000;
                    digit_ref[1] = 8'b00000000;
                    digit_ref[2] = 8'b00000000;
                    digit_ref[3] = 8'b00000000;
                    digit_ref[4] = 8'b00000000;
                    digit_ref[5] = 8'b00000000;
                    digit_ref[6] = 8'b00000000;
                    digit_ref[7] = 8'b00000000;
                end
                4'd1: begin // "T"
                    digit_ref[0] = 8'b01111110;
                    digit_ref[1] = 8'b01111110;
                    digit_ref[2] = 8'b00011000;
                    digit_ref[3] = 8'b00011000;
                    digit_ref[4] = 8'b00011000;
                    digit_ref[5] = 8'b00011000;
                    digit_ref[6] = 8'b00011000;
                    digit_ref[7] = 8'b00011000;
                end
                4'd2: begin // "R"
                    digit_ref[0] = 8'b01111100;
                    digit_ref[1] = 8'b01101110;
                    digit_ref[2] = 8'b01100110;
                    digit_ref[3] = 8'b01111100;
                    digit_ref[4] = 8'b01111000;
                    digit_ref[5] = 8'b01101100;
                    digit_ref[6] = 8'b01100110;
                    digit_ref[7] = 8'b01100110;
                end
                4'd3: begin // "U"
                    digit_ref[0] = 8'b01100110;
                    digit_ref[1] = 8'b01100110;
                    digit_ref[2] = 8'b01100110;
                    digit_ref[3] = 8'b01100110;
                    digit_ref[4] = 8'b01100110;
                    digit_ref[5] = 8'b01100110;
                    digit_ref[6] = 8'b00111100;
                    digit_ref[7] = 8'b00011000;
                end
                4'd4: begin // "E"
                    digit_ref[0] = 8'b01111110;
                    digit_ref[1] = 8'b01100000;
                    digit_ref[2] = 8'b01100000;
                    digit_ref[3] = 8'b01111110;
                    digit_ref[4] = 8'b01111110;
                    digit_ref[5] = 8'b01100000;
                    digit_ref[6] = 8'b01100000;
                    digit_ref[7] = 8'b01111110;
                end
                4'd5: begin // "F"
                    digit_ref[0] = 8'b01111110;
                    digit_ref[1] = 8'b01111110;
                    digit_ref[2] = 8'b01100000;
                    digit_ref[3] = 8'b01111100;
                    digit_ref[4] = 8'b01111100;
                    digit_ref[5] = 8'b01100000;
                    digit_ref[6] = 8'b01100000;
                    digit_ref[7] = 8'b01100000;
                end
                4'd6: begin // "A"
                    digit_ref[0] = 8'b00111100;
                    digit_ref[1] = 8'b01111110;
                    digit_ref[2] = 8'b01100110;
                    digit_ref[3] = 8'b01100110;
                    digit_ref[4] = 8'b01111110;
                    digit_ref[5] = 8'b01100110;
                    digit_ref[6] = 8'b01100110;
                    digit_ref[7] = 8'b01100110;
                end
                4'd7: begin // "L"
                    digit_ref[0] = 8'b01100000;
                    digit_ref[1] = 8'b01100000;
                    digit_ref[2] = 8'b01100000;
                    digit_ref[3] = 8'b01100000;
                    digit_ref[4] = 8'b01100000;
                    digit_ref[5] = 8'b01100000;
                    digit_ref[6] = 8'b01111110;
                    digit_ref[7] = 8'b01111110;
                end
                4'd8: begin // "S"
                    digit_ref[0] = 8'b00111100;
                    digit_ref[1] = 8'b01110110;
                    digit_ref[2] = 8'b01100000;
                    digit_ref[3] = 8'b01111100;
                    digit_ref[4] = 8'b00111110;
                    digit_ref[5] = 8'b00000110;
                    digit_ref[6] = 8'b01110110;
                    digit_ref[7] = 8'b00111100;
                end
                4'd9: begin // "Y"
                    digit_ref[0] = 8'b01100110;
                    digit_ref[1] = 8'b01100110;
                    digit_ref[2] = 8'b01100110;
                    digit_ref[3] = 8'b00111100;
                    digit_ref[4] = 8'b00011000;
                    digit_ref[5] = 8'b00011000;
                    digit_ref[6] = 8'b00011000;
                    digit_ref[7] = 8'b00011000;
                end
                default: begin
                    // Default to space if index is out of range
                    digit_ref[0] = 8'b00000000;
                    digit_ref[1] = 8'b00000000;
                    digit_ref[2] = 8'b00000000;
                    digit_ref[3] = 8'b00000000;
                    digit_ref[4] = 8'b00000000;
                    digit_ref[5] = 8'b00000000;
                    digit_ref[6] = 8'b00000000;
                    digit_ref[7] = 8'b00000000;
                end
            endcase
        end
                    
    always @ (posedge clk_25M) begin
        if (x_pos >= left_x && x_pos <= left_x + 8 - 1 && y_pos >= top_y && y_pos <= top_y + 8 - 1)
            isLetter = digit_ref[y_pos - top_y][x_pos - left_x];
        else
            isLetter = 0;
    end

endmodule
