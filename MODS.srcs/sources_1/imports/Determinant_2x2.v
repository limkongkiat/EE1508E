`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2024 16:57:07
// Design Name: 
// Module Name: Determinant_2x2
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


module determinant_2x2 (input signed [4:0] a11, signed [4:0] a12, signed [4:0] a21, signed [4:0] a22,
    output signed [15:0] det);

    assign det = (a11 * a22) - (a12 * a21);

endmodule
