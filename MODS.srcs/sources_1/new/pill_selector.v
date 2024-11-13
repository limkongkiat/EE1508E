`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2024 23:49:59
// Design Name: 
// Module Name: pill_selector
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


module pill_selector(input MHz25, 
input [6:0] curr_x, [5:0] curr_y, [6:0] left_x, [5:0] top_y, 
input isRight,
output reg isArrow);
    
wire [0:4] E_ref [0:4];
assign E_ref[0] = 5'b11000;
assign E_ref[1] = 5'b11110;
assign E_ref[2] = 5'b11111;
assign E_ref[3] = 5'b11110;
assign E_ref[4] = 5'b11000;

//    wire [7:0]ref_x;
//    assign ref_x = (curr_x - left_x)/scale;
//    wire [6:0]ref_y;
//    assign ref_y = (curr_y - top_y)/scale;
                
always @ (posedge MHz25) begin
    if (curr_x < left_x || curr_x > left_x + 4 || curr_y < top_y || curr_y > top_y + 4)
        isArrow <= 0;
    else if (isRight == 1)
        isArrow <= E_ref[(curr_y - top_y)][(curr_x - left_x)];
    else 
        isArrow <= E_ref[(curr_y - top_y)][4 - (curr_x - left_x)];
end
endmodule
