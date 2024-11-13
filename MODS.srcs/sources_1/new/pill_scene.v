`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2024 15:29:59
// Design Name: 
// Module Name: pill_scene
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


module pill_scene(input clk_25MHz, input clk_1k, input btnL_db, btnR_db, btnC_db, input [12:0] pix_index,
    input active_flag,
    output reg [15:0] oled_colour, output reg exit_flag, output reg escapeMatrix = 0);
    
    wire [15:0] pill_page;
    BRAM_pill pil (.clk(clk_25MHz), .addr(pix_index), .read_write(0), .data_in(0), .data_out(pill_page));
    
    reg [1:0] arrowState = 2;
    
    reg [6:0] arrowX = 100;
    
    wire [6:0] curr_x;
    wire [5:0] curr_y;
    assign curr_x = pix_index % 96;
    assign curr_y = pix_index / 96;
    
    wire isArrow;
    pill_selector ps (.MHz25(clk_25MHz),
    .curr_x(curr_x), .curr_y(curr_y), 
    .left_x(arrowX), .top_y(38), 
    .isRight(arrowState[0]),
    .isArrow(isArrow));
    
    always @ (posedge clk_25MHz) begin
        if (active_flag) begin
            case (arrowState)
                0: begin
                    arrowX <= 34;
                    if (btnC_db) escapeMatrix <= 1;
                    else if (btnR_db && !btnL_db) arrowState <= 1;
                end
                1: begin
                    arrowX <= 58;
                    if (btnC_db) exit_flag <= 1;
                    else if (btnL_db && !btnR_db) arrowState <= 0;
                end
                2: begin
                    arrowX <= 100;
                    if (btnL_db && !btnR_db) arrowState <= 0;
                    else if (btnR_db && !btnL_db) arrowState <= 1;
                end
            endcase
        end
        else begin
            exit_flag <= 0;
            arrowState <= 2;
        end
    end
    
    always @ (posedge clk_25MHz) begin
        if (isArrow)
            oled_colour <= 16'b00000_111111_00000;
        else
            oled_colour <= pill_page;
    end
endmodule
