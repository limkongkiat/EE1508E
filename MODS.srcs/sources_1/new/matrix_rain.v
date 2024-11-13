`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.10.2024 22:57:22
// Design Name: 
// Module Name: matrix_rain
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


module matrix_rain(input clk, input [7:0] curr_x, input [6:0] curr_y, input [7:0] x_coord, input[4:0] init_delay, output reg [15:0] col);

wire [10:0] isSpM;
reg [4:0] state_checker = 31;

reg [5:0] init_counter = 0;

wire Hz10;
flexi_clock clk_4Hz (.basys_clk(clk), .my_m_value(4_999_999), .my_clk(Hz10));

always @ (posedge Hz10) begin
    init_counter <= (init_counter == init_delay) ? init_counter : init_counter + 1;
    state_checker <= (init_counter == init_delay) ? state_checker + 1 : state_checker;
end

    wire MHz25;
    flexi_clock clk_25MHz (.basys_clk(clk), .my_m_value(1), .my_clk(MHz25));

    always @ (posedge MHz25) begin
        if (state_checker <= 10 && isSpM[state_checker])
                col <= 16'b11111_111111_11111;
        else if (state_checker >= 1 && state_checker <= 11 && isSpM[state_checker - 1])
                col <= 16'b00000_011010_00000;
        else if (state_checker >= 2 && state_checker <= 12 && isSpM[state_checker - 2])
                col <= 16'b00000_011010_00000;
        else if (state_checker >= 3 && state_checker <= 13 && isSpM[state_checker - 3])
                col <= 16'b00000_011010_00000;
        else
                col <= 0;
    end

letter_display M (.clk_25M(MHz25),
    .left_x(x_coord),
    .top_y(0),
    .x_pos(curr_x),
    .y_pos(curr_y),
    .scale(1),
    .letter(13),
    .isLetter(isSpM[0])
    );        

letter_display A (.clk_25M(MHz25),
    .left_x(x_coord),
    .top_y(6),
    .x_pos(curr_x),
    .y_pos(curr_y),
    .scale(1),
    .letter(1),
    .isLetter(isSpM[1])
    );
    
letter_display T (.clk_25M(MHz25),
        .left_x(x_coord),
        .top_y(12),
        .x_pos(curr_x),
        .y_pos(curr_y),
        .scale(1),
        .letter(20),
        .isLetter(isSpM[2])
        );

    
letter_display R (.clk_25M(MHz25),
        .left_x(x_coord),
        .top_y(18),
        .x_pos(curr_x),
        .y_pos(curr_y),
        .scale(1),
        .letter(18),
        .isLetter(isSpM[3])
        );

    
letter_display I (.clk_25M(MHz25),
        .left_x(x_coord),
        .top_y(24),
        .x_pos(curr_x),
        .y_pos(curr_y),
        .scale(1),
        .letter(9),
        .isLetter(isSpM[4])
        );

letter_display X (.clk_25M(MHz25),
    .left_x(x_coord),
    .top_y(30),
    .x_pos(curr_x),
    .y_pos(curr_y),
    .scale(1),
    .letter(24),
    .isLetter(isSpM[5])
    );

 letter_display M2 (.clk_25M(MHz25),
    .left_x(x_coord),
    .top_y(36),
    .x_pos(curr_x),
    .y_pos(curr_y),
    .scale(1),
    .letter(13),
    .isLetter(isSpM[6])
    );        

letter_display A2 (.clk_25M(MHz25),
    .left_x(x_coord),
    .top_y(42),
    .x_pos(curr_x),
    .y_pos(curr_y),
    .scale(1),
    .letter(1),
    .isLetter(isSpM[7])
    );
    
letter_display T2 (.clk_25M(MHz25),
        .left_x(x_coord),
        .top_y(48),
        .x_pos(curr_x),
        .y_pos(curr_y),
        .scale(1),
        .letter(20),
        .isLetter(isSpM[8])
        );

    
letter_display R2 (.clk_25M(MHz25),
        .left_x(x_coord),
        .top_y(54),
        .x_pos(curr_x),
        .y_pos(curr_y),
        .scale(1),
        .letter(18),
        .isLetter(isSpM[9])
        );

    
letter_display I2 (.clk_25M(MHz25),
        .left_x(x_coord),
        .top_y(60),
        .x_pos(curr_x),
        .y_pos(curr_y),
        .scale(1),
        .letter(9),
        .isLetter(isSpM[10])
        );

endmodule
