`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2024 10:00:44
// Design Name: 
// Module Name: display_number_5x5
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


module display_number_5x5(input clk, [6:0] x_coord, [5:0] y_coord, [6:0] x_offset, [5:0] y_offset, [1:0] scale, [3:0] number, output reg is_coloured);
    
    wire clk_25MHz;
    flexi_clock clk_25M(clk, 1, clk_25MHz);
    
    reg [0:4] char [0:4];

    always @ (posedge clk_25MHz) begin
        case (number)
            4'd0: begin
                char[0] = 5'b00100;
                char[1] = 5'b01010;
                char[2] = 5'b01010;
                char[3] = 5'b01010;
                char[4] = 5'b00100;
            end
            4'd1: begin
                char[0] = 5'b00100;
                char[1] = 5'b01100;
                char[2] = 5'b00100;
                char[3] = 5'b00100;
                char[4] = 5'b01110;
            end
            4'd2: begin
                char[0] = 5'b01100;
                char[1] = 5'b00010;
                char[2] = 5'b00110;
                char[3] = 5'b01000;
                char[4] = 5'b01110;
            end
            4'd3: begin
                char[0] = 5'b01100;
                char[1] = 5'b00010;
                char[2] = 5'b01100;
                char[3] = 5'b00010;
                char[4] = 5'b01100;
            end
            4'd4: begin
                char[0] = 5'b00010;
                char[1] = 5'b00110;
                char[2] = 5'b01010;
                char[3] = 5'b01111;
                char[4] = 5'b00010;
            end
            4'd5: begin
                char[0] = 5'b01110;
                char[1] = 5'b01000;
                char[2] = 5'b01100;
                char[3] = 5'b00010;
                char[4] = 5'b01100;
            end
            4'd6: begin
                char[0] = 5'b00110;
                char[1] = 5'b01000;
                char[2] = 5'b01110;
                char[3] = 5'b01001;
                char[4] = 5'b00110;
            end
            4'd7: begin
                char[0] = 5'b01110;
                char[1] = 5'b01010;
                char[2] = 5'b00010;
                char[3] = 5'b00010;
                char[4] = 5'b00010;
            end
            4'd8: begin
                char[0] = 5'b00110;
                char[1] = 5'b01001;
                char[2] = 5'b00110;
                char[3] = 5'b01001;
                char[4] = 5'b00110;
            end
            4'd9: begin
                char[0] = 5'b00110;
                char[1] = 5'b01001;
                char[2] = 5'b00111;
                char[3] = 5'b00001;
                char[4] = 5'b00110;
            end
            4'd10: begin // minus
                char[0] = 5'b00000;
                char[1] = 5'b00000;
                char[2] = 5'b01110;
                char[3] = 5'b00000;
                char[4] = 5'b00000;
            end
            default: begin // space
                char[0] = 5'b00000;
                char[1] = 5'b00000;
                char[2] = 5'b00000;
                char[3] = 5'b00000;
                char[4] = 5'b00000;
            end
        endcase
    end

    always @ (posedge clk_25MHz) begin
        if (x_coord >= x_offset && x_coord <= x_offset + 5 * scale - 1 && y_coord >= y_offset && y_coord <= y_offset + 5 * scale - 1)
            is_coloured = char[(y_coord - y_offset) / scale][(x_coord - x_offset) / scale];
        else
            is_coloured = 0;
    end
endmodule