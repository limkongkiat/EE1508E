`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2024 17:35:31
// Design Name: 
// Module Name: letter_display
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


module letter_display(
    input clk_25M,
    input [6:0] left_x,
    input [5:0] top_y,
    input [6:0] x_pos,
    input [5:0] y_pos,
    input [3:0] scale,
    input [4:0] letter,
    output reg isLetter = 0
    );
    
    reg [0:4] digit_ref [0:4];
        always @ (posedge clk_25M) begin
        case (letter)
            5'd0: begin //space
                digit_ref[0] = 5'b00000;
                digit_ref[1] = 5'b00000;
                digit_ref[2] = 5'b00000;
                digit_ref[3] = 5'b00000;
                digit_ref[4] = 5'b00000;
            end
            5'd1: begin //A
                digit_ref[0] = 5'b01100;
                digit_ref[1] = 5'b10010;
                digit_ref[2] = 5'b10010;
                digit_ref[3] = 5'b11110;
                digit_ref[4] = 5'b10010;
            end
            5'd2: begin //B
                digit_ref[0] = 5'b11100;
                digit_ref[1] = 5'b10010;
                digit_ref[2] = 5'b11100;
                digit_ref[3] = 5'b10010;
                digit_ref[4] = 5'b11100;
            end
            5'd3: begin //C
                digit_ref[0] = 5'b01100;
                digit_ref[1] = 5'b10010;
                digit_ref[2] = 5'b10000;
                digit_ref[3] = 5'b10010;
                digit_ref[4] = 5'b01100;
            end
            5'd4: begin //D
                digit_ref[0] = 5'b11100;
                digit_ref[1] = 5'b10010;
                digit_ref[2] = 5'b10010;
                digit_ref[3] = 5'b10010;
                digit_ref[4] = 5'b11100;
            end
            5'd5: begin //E
                digit_ref[0] = 5'b01110;
                digit_ref[1] = 5'b10000;
                digit_ref[2] = 5'b11100;
                digit_ref[3] = 5'b10000;
                digit_ref[4] = 5'b01110;
            end
            5'd6: begin //F
                digit_ref[0] = 5'b01110;
                digit_ref[1] = 5'b10000;
                digit_ref[2] = 5'b11100;
                digit_ref[3] = 5'b10000;
                digit_ref[4] = 5'b10000;
            end
            5'd7: begin //G
                digit_ref[0] = 5'b01110;
                digit_ref[1] = 5'b10000;
                digit_ref[2] = 5'b10110;
                digit_ref[3] = 5'b10010;
                digit_ref[4] = 5'b01100;
            end
            5'd8: begin //H
                digit_ref[0] = 5'b10010;
                digit_ref[1] = 5'b10010;
                digit_ref[2] = 5'b11110;
                digit_ref[3] = 5'b10010;
                digit_ref[4] = 5'b10010;
            end
            5'd9: begin //I
                digit_ref[0] = 5'b11100;
                digit_ref[1] = 5'b01000;
                digit_ref[2] = 5'b01000;
                digit_ref[3] = 5'b01000;
                digit_ref[4] = 5'b11100;
            end
            5'd10: begin //J
                digit_ref[0] = 5'b11100;
                digit_ref[1] = 5'b00100;
                digit_ref[2] = 5'b00100;
                digit_ref[3] = 5'b10100;
                digit_ref[4] = 5'b01100;
            end
            5'd11: begin //K
                digit_ref[0] = 5'b10010;
                digit_ref[1] = 5'b10100;
                digit_ref[2] = 5'b11000;
                digit_ref[3] = 5'b10100;
                digit_ref[4] = 5'b10010;
            end
            5'd12: begin //L
                digit_ref[0] = 5'b10000;
                digit_ref[1] = 5'b10000;
                digit_ref[2] = 5'b10000;
                digit_ref[3] = 5'b10000;
                digit_ref[4] = 5'b11100;
            end
            5'd13: begin //M
                digit_ref[0] = 5'b01010;
                digit_ref[1] = 5'b10101;
                digit_ref[2] = 5'b10101;
                digit_ref[3] = 5'b10001;
                digit_ref[4] = 5'b10001;
            end
            5'd14: begin //N
                digit_ref[0] = 5'b10010;
                digit_ref[1] = 5'b10010;
                digit_ref[2] = 5'b11010;
                digit_ref[3] = 5'b10110;
                digit_ref[4] = 5'b10010;
            end
            5'd15: begin //O
                digit_ref[0] = 5'b01100;
                digit_ref[1] = 5'b10010;
                digit_ref[2] = 5'b10010;
                digit_ref[3] = 5'b10010;
                digit_ref[4] = 5'b01100;
            end
            5'd16: begin //P
                digit_ref[0] = 5'b01100;
                digit_ref[1] = 5'b10010;
                digit_ref[2] = 5'b11100;
                digit_ref[3] = 5'b10000;
                digit_ref[4] = 5'b10000;
            end
            5'd17: begin //Q
                digit_ref[0] = 5'b01100;
                digit_ref[1] = 5'b10010;
                digit_ref[2] = 5'b10110;
                digit_ref[3] = 5'b10010;
                digit_ref[4] = 5'b01101;
            end
            5'd18: begin //R
                digit_ref[0] = 5'b11100;
                digit_ref[1] = 5'b10010;
                digit_ref[2] = 5'b11100;
                digit_ref[3] = 5'b10010;
                digit_ref[4] = 5'b10010;
            end
            5'd19: begin //S
                digit_ref[0] = 5'b01110;
                digit_ref[1] = 5'b10000;
                digit_ref[2] = 5'b01100;
                digit_ref[3] = 5'b00010;
                digit_ref[4] = 5'b11100;
            end
            5'd20: begin //T
                digit_ref[0] = 5'b11100;
                digit_ref[1] = 5'b01000;
                digit_ref[2] = 5'b01000;
                digit_ref[3] = 5'b01000;
                digit_ref[4] = 5'b01000;
            end
            5'd21: begin //U
                digit_ref[0] = 5'b10010;
                digit_ref[1] = 5'b10010;
                digit_ref[2] = 5'b10010;
                digit_ref[3] = 5'b10010;
                digit_ref[4] = 5'b01100;
            end
            5'd22: begin //V
                digit_ref[0] = 5'b10001;
                digit_ref[1] = 5'b10001;
                digit_ref[2] = 5'b10001;
                digit_ref[3] = 5'b01010;
                digit_ref[4] = 5'b00100;
            end
            5'd23: begin //W
                digit_ref[0] = 5'b10001;
                digit_ref[1] = 5'b10101;
                digit_ref[2] = 5'b10101;
                digit_ref[3] = 5'b10101;
                digit_ref[4] = 5'b01110;
            end
            5'd24: begin //X
                digit_ref[0] = 5'b10100;
                digit_ref[1] = 5'b10100;
                digit_ref[2] = 5'b01000;
                digit_ref[3] = 5'b10100;
                digit_ref[4] = 5'b10100;
            end
            5'd25: begin //Y
                digit_ref[0] = 5'b10100;
                digit_ref[1] = 5'b10100;
                digit_ref[2] = 5'b11100;
                digit_ref[3] = 5'b01000;
                digit_ref[4] = 5'b01000;
            end
            5'd26: begin //Z
                digit_ref[0] = 5'b11110;
                digit_ref[1] = 5'b00010;
                digit_ref[2] = 5'b00100;
                digit_ref[3] = 5'b01000;
                digit_ref[4] = 5'b11110;
            end
            5'd27: begin //period
                digit_ref[0] = 5'b00000;
                digit_ref[1] = 5'b00000;
                digit_ref[2] = 5'b00000;
                digit_ref[3] = 5'b01100;
                digit_ref[4] = 5'b01100;
            end
            5'd28: begin //comma
                digit_ref[0] = 5'b00000;
                digit_ref[1] = 5'b00000;
                digit_ref[2] = 5'b01100;
                digit_ref[3] = 5'b01100;
                digit_ref[4] = 5'b11000;
            end
            5'd29: begin //colon
                digit_ref[0] = 5'b11000;
                digit_ref[1] = 5'b11000;
                digit_ref[2] = 5'b00000;
                digit_ref[3] = 5'b11000;
                digit_ref[4] = 5'b11000;                
            end
            5'd30: begin //plus
                digit_ref[0] = 5'b00100;
                digit_ref[1] = 5'b00100;
                digit_ref[2] = 5'b11111;
                digit_ref[3] = 5'b00100;
                digit_ref[4] = 5'b00100;
            end
            5'd31: begin //minus
                digit_ref[0] = 5'b00000;
                digit_ref[1] = 5'b00000;
                digit_ref[2] = 5'b11111;
                digit_ref[3] = 5'b00000;
                digit_ref[4] = 5'b00000;
            end
            default: begin //idk blank
                digit_ref[0] = 5'b00000;
                digit_ref[1] = 5'b00000;
                digit_ref[2] = 5'b00000;
                digit_ref[3] = 5'b00000;
                digit_ref[4] = 5'b00000;
            end
        endcase
    end
                    
    always @ (posedge clk_25M) begin
        if (x_pos >= left_x && x_pos <= left_x + 5 * scale - 1 && y_pos >= top_y && y_pos <= top_y + 5 * scale - 1)
            isLetter = digit_ref[(y_pos - top_y)/scale][(x_pos - left_x)/scale];
        else
            isLetter = 0;
    end
endmodule
