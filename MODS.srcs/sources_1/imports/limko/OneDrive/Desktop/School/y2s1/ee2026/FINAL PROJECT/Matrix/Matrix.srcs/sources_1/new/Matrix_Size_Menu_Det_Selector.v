`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 11:35:29
// Design Name: 
// Module Name: matrix_size_det_selector
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


module matrix_size_selector(input clk, input btnU_db, btnL_db, btnD_db, btnR_db, btnC_db,
    input active_flag, input [1:0] row_restriction, // specificies if only that row is available, 0 means none
    input [1:0] number_of_rows, [1:0] number_of_cols,
    output reg [1:0] row = 0, reg [1:0] col = 0,
    output reg complete_selection = 0);

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
        if (!run_once_flag) begin
            run_once_flag <= 1;
            col <= 0;
            if (row_restriction != 0) begin
                row <= row_restriction - 1;
            end
            else begin
                row <= 0;
            end
        end
        if (active_flag) begin
            if (btnU_db && pb_released && row > 0) begin
                if (row_restriction == 0) begin
                    row <= row - 1;
                end
                pb_released <= 0;
            end
            else if (btnD_db && pb_released && row < number_of_rows - 1) begin
                if (row_restriction == 0) begin
                    row <= row + 1;
                end
                pb_released <= 0;
            end
            else if (btnL_db && pb_released && col > 0) begin
                col <= col - 1;
                pb_released <= 0;
            end
            else if (btnR_db && pb_released && col < number_of_cols - 1) begin
                col <= col + 1;
                pb_released <= 0;
            end
            else if (btnC_db && pb_released) begin
                complete_selection <= 1;
                pb_released <= 0;
            end
            else if (!btnC_db && !btnU_db && !btnL_db && !btnD_db && !btnR_db && !pb_released) begin
                pb_released <= 1;
            end
        end
    end

endmodule