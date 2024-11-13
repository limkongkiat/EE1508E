`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 21:56:19
// Design Name: 
// Module Name: input_matrix_disp
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


module input_matrix_disp(
    input clk, [6:0] curr_x, [5:0] curr_y, 
    input [1:0] rows, [1:0] cols,
    input signed [4:0] num1, signed [4:0] num2, signed [4:0] num3, signed [4:0] num4, signed [4:0] num5, signed [4:0] num6, signed [4:0] num7, signed [4:0] num8, signed [4:0] num9,
    output [1:0] isMatrix
    );
    
    wire signed [4:0] num [8:0];
    assign num[0] = num1;
    assign num[1] = num2;
    assign num[2] = num3;
    assign num[3] = num4;
    assign num[4] = num5;
    assign num[5] = num6;
    assign num[6] = num7;
    assign num[7] = num8;
    assign num[8] = num9;
    
    wire MHz25;
    flexi_clock clk_25MHz (.basys_clk(clk), .my_m_value(1), .my_clk(MHz25));

    parameter TOP = 17;

    //LEFT = 37 - 9 * (cols - 1);
    
    wire isBracket1;
    matrix_bracket b1(
        .clk_25MHz(MHz25), .curr_x(curr_x), .curr_y(curr_y), 
        .top(TOP), .bottom(TOP + 14*rows + 1), .left(46 - 9 * cols), .isOpen(1),
        .isBracket(isBracket1)
        );
        
    wire isBracket2;
    matrix_bracket b2(
        .clk_25MHz(MHz25), .curr_x(curr_x), .curr_y(curr_y), 
        .top(TOP), .bottom(TOP + 14*rows + 1), .left(48 + 9 * cols), .isOpen(0),
        .isBracket(isBracket2)
        );
    
    wire [8:0] isNum;
    
    genvar i;
    generate
        for (i = 0; i < 9; i = i + 1) begin: digits_block
            signed_dig_disp disp_i(
            MHz25, curr_x, curr_y, 48 - 9 * cols + 18*(i%3), 19 + 14*(i/3), 2, num[i], isNum[i]
            );
        end
    endgenerate
    
    assign isMatrix[0] = (isBracket1 || isBracket2) ? 1 : 0;
    assign isMatrix[1] = isNum != 0;
    
endmodule
