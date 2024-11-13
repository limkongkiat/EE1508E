`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 10:39:18
// Design Name: 
// Module Name: text_scroll
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


module text_scroll #(parameter [3:0] NUM_QUESTIONS = 10)( // this is the default, this CAN be overridden in instantiation
    input clk25M,
    input active_flag,
    input pb_up, pb_down,
    input [3:0] question_num, // CHECK THE SIZE
    input [(4 * NUM_QUESTIONS) - 1:0] question_row_count,
    output reg [2:0] scroll_offset = 0
    );
    
    wire clk_1k;
    flexi_clock clk_1kHz (.basys_clk(clk25M), .my_m_value(12_499), .my_clk(clk_1k));
    
    localparam [2:0] MAX_DISPLAYED_ROWS = 6;
    
    reg [3:0] question_num_prev = 0;
    reg pb_up_prev = 0;
    reg pb_down_prev = 0;
    always @ (posedge clk_1k)
    begin
        if (!active_flag) begin
            scroll_offset <= 0; // reset scroll_offset
        end else begin
            question_num_prev <= question_num;
            pb_up_prev <= pb_up;
            pb_down_prev <= pb_down;

            // reset scrolling amount every question change
            if (question_num != question_num_prev) begin
                scroll_offset <= 0;
            end else begin
                // downscroll (scrolling down)
                if (question_row_count[4 * question_num +: 4] <= MAX_DISPLAYED_ROWS) begin
                    // If there are fewer or exactly MAX_DISPLAYED_ROWS, don't scroll at all
                    scroll_offset <= 0;
                end else if (pb_down && !pb_down_prev) begin
                    if (scroll_offset + MAX_DISPLAYED_ROWS + 1 < question_row_count[4 * question_num +: 4]) // Clamp downscroll
                        scroll_offset <= scroll_offset + 1;
                    else
                        scroll_offset <= question_row_count[4 * question_num +: 4] - MAX_DISPLAYED_ROWS < 0
                                ? 0 : question_row_count[4 * question_num +: 4] - MAX_DISPLAYED_ROWS - 1; // Clamp to max visible rows
                end
                
                // upscroll (scrolling up)
                if (question_row_count[4 * question_num +: 4] <= MAX_DISPLAYED_ROWS) begin
                    // If there are fewer or exactly MAX_DISPLAYED_ROWS, don't scroll at all
                    scroll_offset <= 0;
                end else if (pb_up && !pb_up_prev) begin
                    if (scroll_offset > 0) // Clamp upscroll
                        scroll_offset <= scroll_offset - 1;
                end
            end
        end
    end
    
endmodule
