`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 23:06:43
// Design Name: 
// Module Name: matrix_bracket
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


module matrix_bracket(
    input clk_25MHz, [6:0] curr_x, [5:0] curr_y, 
    [5:0] top, [5:0] bottom, [6:0] left, isOpen,
    output reg isBracket = 0
    );
    
    always @ (posedge clk_25MHz) begin
        if (isOpen == 1) begin
            if (curr_x >= left && curr_x <= left + 1 && curr_y >= top && curr_y <= bottom)
                isBracket <= 1;
            else if (curr_x >= left && curr_x <= left + 3 && ((curr_y >= top && curr_y <= top + 1) || (curr_y >= bottom - 1 && curr_y <= bottom)))
                isBracket <= 1;
            else isBracket <= 0;
        end
        else begin
            if (curr_x >= left + 2 && curr_x <= left + 3 && curr_y >= top && curr_y <= bottom)
                isBracket <= 1;
            else if (curr_x >= left && curr_x <= left + 1 && ((curr_y >= top && curr_y <= top + 1) || (curr_y >= bottom - 1 && curr_y <= bottom)))
                isBracket <= 1;
            else isBracket <= 0;
        end
    end
    
endmodule
