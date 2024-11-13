`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.10.2024 09:08:42
// Design Name: 
// Module Name: index_to_coordinate
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


module index_to_coordinates(input [12:0] index, output [6:0] x, output [5:0] y);

    assign x = index % 96;
    assign y = index / 96;

endmodule
