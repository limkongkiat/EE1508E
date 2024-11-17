`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 10:33:27
// Design Name: 
// Module Name: signed_dig_disp
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


module signed_dig_disp(
    input clk,
    input [6:0] curr_x, [5:0] curr_y, [6:0] left_x, [5:0] top_y,
    input [3:0] scale, signed [4:0] digit,
    output reg isDigit = 0
    );
    
    wire MHz25;
    flexi_clock clk_25MHz (.basys_clk(clk), .my_m_value(1), .my_clk(MHz25));
    
    reg [0:7] digit_ref [0:4];
        always @ (posedge MHz25) begin
        case (digit)
            0: begin
                digit_ref[0] = 8'b00011000;
                digit_ref[1] = 8'b00100100;
                digit_ref[2] = 8'b00100100;
                digit_ref[3] = 8'b00100100;
                digit_ref[4] = 8'b00011000;
                //digit_ref[5] = 8'b00000000;
            end
            1: begin
                digit_ref[0] = 8'b00001000;
                digit_ref[1] = 8'b00011000;
                digit_ref[2] = 8'b00001000;
                digit_ref[3] = 8'b00001000;
                digit_ref[4] = 8'b00011100;
                //digit_ref[5] = 8'b00000000;
            end
            2: begin
                digit_ref[0] = 8'b00111000;
                digit_ref[1] = 8'b00000100;
                digit_ref[2] = 8'b00001100;
                digit_ref[3] = 8'b00010000;
                digit_ref[4] = 8'b00111100;
                //digit_ref[5] = 8'b00000000;
            end
            3: begin
                digit_ref[0] = 8'b00111000;
                digit_ref[1] = 8'b00000100;
                digit_ref[2] = 8'b00111000;
                digit_ref[3] = 8'b00000100;
                digit_ref[4] = 8'b00111000;
                //digit_ref[5] = 8'b00000000;
            end
            4: begin
                digit_ref[0] = 8'b00001000;
                digit_ref[1] = 8'b00011000;
                digit_ref[2] = 8'b00101000;
                digit_ref[3] = 8'b00111100;
                digit_ref[4] = 8'b00001000;
               // digit_ref[5] = 8'b00000000;
            end
            5: begin
                digit_ref[0] = 8'b00011100;
                digit_ref[1] = 8'b00010000;
                digit_ref[2] = 8'b00011000;
                digit_ref[3] = 8'b00000100;
                digit_ref[4] = 8'b00011000;
                //digit_ref[5] = 8'b00000000;
            end
            6: begin
                digit_ref[0] = 8'b00011000;
                digit_ref[1] = 8'b00100000;
                digit_ref[2] = 8'b00111000;
                digit_ref[3] = 8'b00100100;
                digit_ref[4] = 8'b00011000;
                //digit_ref[5] = 8'b00000000;
            end
            7: begin
                digit_ref[0] = 8'b00111100;
                digit_ref[1] = 8'b00100100;
                digit_ref[2] = 8'b00000100;
                digit_ref[3] = 8'b00000100;
                digit_ref[4] = 8'b00000100;
                //digit_ref[5] = 8'b00000000;
            end
            8: begin
                digit_ref[0] = 8'b00011000;
                digit_ref[1] = 8'b00100100;
                digit_ref[2] = 8'b00011000;
                digit_ref[3] = 8'b00100100;
                digit_ref[4] = 8'b00011000;
                //digit_ref[5] = 8'b00000000;
            end
            9: begin
                digit_ref[0] = 8'b00011000;
                digit_ref[1] = 8'b00100100;
                digit_ref[2] = 8'b00011100;
                digit_ref[3] = 8'b00000100;
                digit_ref[4] = 8'b00011000;
                //digit_ref[5] = 8'b00000000;
            end
            -1: begin
                digit_ref[0] = 8'b00000100;
                digit_ref[1] = 8'b00001100;
                digit_ref[2] = 8'b11000100;
                digit_ref[3] = 8'b00000100;
                digit_ref[4] = 8'b00001110;
                //digit_ref[5] = 8'b00000000;
            end
            -2: begin
                digit_ref[0] = 8'b00011100;
                digit_ref[1] = 8'b00000010;
                digit_ref[2] = 8'b11000110;
                digit_ref[3] = 8'b00001000;
                digit_ref[4] = 8'b00011110;
                //digit_ref[5] = 8'b00000000;
            end
            -3: begin
                digit_ref[0] = 8'b00011100;
                digit_ref[1] = 8'b00000010;
                digit_ref[2] = 8'b11001100;
                digit_ref[3] = 8'b00000010;
                digit_ref[4] = 8'b00011100;
                //digit_ref[5] = 8'b00000000;
            end
            -4: begin
                digit_ref[0] = 8'b00000010;
                digit_ref[1] = 8'b00000110;
                digit_ref[2] = 8'b11001010;
                digit_ref[3] = 8'b00001111;
                digit_ref[4] = 8'b00000010;
                //digit_ref[5] = 8'b00000000;
            end
            -5: begin
                digit_ref[0] = 8'b00000111;
                digit_ref[1] = 8'b00000100;
                digit_ref[2] = 8'b11000110;
                digit_ref[3] = 8'b00000001;
                digit_ref[4] = 8'b00000110;
                //digit_ref[5] = 8'b00000000;
            end
            -6: begin
                digit_ref[0] = 8'b00000110;
                digit_ref[1] = 8'b00001000;
                digit_ref[2] = 8'b11001110;
                digit_ref[3] = 8'b00001001;
                digit_ref[4] = 8'b00000110;
                //digit_ref[5] = 8'b00000000;
            end
            -7: begin
                digit_ref[0] = 8'b00001111;
                digit_ref[1] = 8'b00001001;
                digit_ref[2] = 8'b11000001;
                digit_ref[3] = 8'b00000001;
                digit_ref[4] = 8'b00000001;
                //digit_ref[5] = 8'b00000000;
            end
            -8: begin
                digit_ref[0] = 8'b00000110;
                digit_ref[1] = 8'b00001001;
                digit_ref[2] = 8'b11000110;
                digit_ref[3] = 8'b00001001;
                digit_ref[4] = 8'b00000110;
                //digit_ref[5] = 8'b00000000;
            end
            -9: begin
                digit_ref[0] = 8'b00000110;
                digit_ref[1] = 8'b00001001;
                digit_ref[2] = 8'b11000111;
                digit_ref[3] = 8'b00000001;
                digit_ref[4] = 8'b00000110;
                //digit_ref[5] = 8'b00000000;
            end
            10: begin //X
                digit_ref[0] = 8'b00100010;
                digit_ref[1] = 8'b00010100;
                digit_ref[2] = 8'b00001000;
                digit_ref[3] = 8'b00010100;
                digit_ref[4] = 8'b00100010;
                //digit_ref[5] = 8'b00000000;
            end
            11: begin //A
                digit_ref[0] = 8'b00011000;
                digit_ref[1] = 8'b00100100;
                digit_ref[2] = 8'b00111100;
                digit_ref[3] = 8'b00100100;
                digit_ref[4] = 8'b00100100;
                //digit_ref[5] = 8'b00000000;
            end
            12: begin // Q
                digit_ref[0] = 8'b00111000;
                digit_ref[1] = 8'b01000100;
                digit_ref[2] = 8'b01010100;
                digit_ref[3] = 8'b01001100;
                digit_ref[4] = 8'b00111010;
                //digit_ref[5] = 8'b00000000;
            end
            13: begin // /
                digit_ref[0] = 8'b00001100;
                digit_ref[1] = 8'b00001100;
                digit_ref[2] = 8'b00011000;
                digit_ref[3] = 8'b00011000;
                digit_ref[4] = 8'b00110000;
                //digit_ref[5] = 8'b00000000;
            end
            14: begin // -
                digit_ref[0] = 8'b00000000;
                digit_ref[1] = 8'b00000000;
                digit_ref[2] = 8'b00111100;
                digit_ref[3] = 8'b00000000;
                digit_ref[4] = 8'b00000000;
                //digit_ref[5] = 8'b00000000;
            end
            default: begin
                digit_ref[0] = 8'b00000000;
                digit_ref[1] = 8'b00000000;
                digit_ref[2] = 8'b00000000;
                digit_ref[3] = 8'b00000000;
                digit_ref[4] = 8'b00000000;
                //digit_ref[5] = 8'b00000000;
            end
        endcase
    end
                    
    always @ (posedge MHz25) begin
        if (curr_x >= left_x && curr_x <= left_x + 8 * scale - 1 && curr_y >= top_y && curr_y <= top_y + 5 * scale - 1)
            isDigit = digit_ref[(curr_y - top_y)/scale][(curr_x - left_x)/scale];
        else
            isDigit = 0;
    end
endmodule
