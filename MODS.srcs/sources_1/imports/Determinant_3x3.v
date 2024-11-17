`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2024 17:53:06
// Design Name: 
// Module Name: Determinant_3x3
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


module determinant_3x3 (input signed [4:0] a11, a12, a13, a21, a22, a23, a31, a32, a33,
    output [15:0] det);

    assign det = a11 * ((a22 * a33) - (a23 * a32)) -
        a12 * ((a21 * a33) - (a23 * a31)) + a13 * ((a21 * a32) - (a22 * a31));

endmodule
