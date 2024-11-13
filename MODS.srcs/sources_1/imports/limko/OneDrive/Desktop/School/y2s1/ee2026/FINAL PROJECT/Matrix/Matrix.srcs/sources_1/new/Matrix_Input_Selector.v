`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2024 16:00:37
// Design Name: 
// Module Name: Matrix_Input_Selector
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


module matrix_input_selector(input clk, input btnU_db, btnL_db, btnD_db, btnR_db, btnC_db,
    input active_flag, pause_flag,
    input [1:0] number_of_rows, [1:0] number_of_cols,
    output reg [1:0] row = 0, reg [1:0] col = 0,
    output reg complete_selection = 0, output reg select_term = 0);

    wire clk_1kHz;
    flexi_clock clk_1k(clk, 49_999, clk_1kHz);

    reg run_once_flag = 0;
    reg pb_released = 0;

    always @ (posedge clk_1kHz) begin
        if (!active_flag) begin
            run_once_flag <= 0;
            complete_selection <= 0;
            pb_released <= 0;
        end
        else if (!run_once_flag) begin
            run_once_flag <= 1;
            col <= 0;
            row <= 0;
        end
        if (active_flag && !pause_flag) begin
            if (btnU_db && pb_released && row > 0 && col != number_of_cols) begin
                row <= row - 1;
                pb_released <= 0;
            end
            else if (btnD_db && pb_released && row < number_of_rows - 1) begin
                row <= row + 1;
                pb_released <= 0;
            end
            else if (btnL_db && pb_released && col > 0) begin
                col <= col - 1;
                pb_released <= 0;
            end
            else if (btnR_db && pb_released && col < number_of_cols) begin
                col <= col + 1;
                pb_released <= 0;
                if (col == number_of_cols - 1) begin
                    row <= number_of_rows - 1;
                end
            end
            else if (btnC_db && pb_released) begin
                pb_released <= 0;
                if (col == number_of_cols) begin
                    complete_selection <= 1;
                end
                else begin
                    select_term <= 1;
                end
            end
            else if (!btnC_db && !btnU_db && !btnL_db && !btnD_db && !btnR_db && !pb_released) begin
                pb_released <= 1;
            end
        end
        else begin
            select_term <= 0;
        end
    end
endmodule
