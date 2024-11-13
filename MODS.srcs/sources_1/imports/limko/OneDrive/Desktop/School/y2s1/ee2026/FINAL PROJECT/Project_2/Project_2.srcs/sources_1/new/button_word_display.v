`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2024 16:12:37
// Design Name: 
// Module Name: button_word_display
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


module button_word_display(
    input clk_25M,
    input [6:0] start_x,
    input [5:0] start_y,
    input [6:0] x_pos, [5:0] y_pos,
    input [24:0] sentence, // 5 letters max
    output isLetter
    );
    
    wire [4:0] letter [0:4];  // Unpack the flattened array back into a 2D form    
    genvar col_idx;
    generate
        for (col_idx = 0; col_idx < 5; col_idx = col_idx + 1) begin
            assign letter[col_idx] = sentence[5 * col_idx +: 5];  // Extract 5 bits for each letter
        end
    endgenerate
    
//     Calculate offsets and display letters
    wire [5:0] isLetter_array;
    generate
        for (col_idx = 0; col_idx < 5; col_idx = col_idx + 1) begin : col_loop
            button_letter_display letter_inst (
                .clk_25M(clk_25M),
                .left_x(start_x + col_idx * 8),  // Increment by 8 for each letter
                .top_y(start_y),
                .x_pos(x_pos),
                .y_pos(y_pos),
                .letter(letter[col_idx]),        // Letter from the unpacked array
                .isLetter(isLetter_array[col_idx])
            );
        end
    endgenerate
    
    assign isLetter = |isLetter_array; // is 1 if any letter is on
    
endmodule
