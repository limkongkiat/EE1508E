`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2024 13:19:39
// Design Name: 
// Module Name: numpad_selector
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


module numpad_selector(input clk, btnU_db, btnL_db, btnD_db, btnR_db, btnC_db,
    input signed [4:0] prv_num, input active_flag,
    output reg [1:0] row = 0, reg [1:0] col = 0,
    output reg signed [4:0] selected_num = 0, output reg complete_selection = 0);

    wire clk_1kHz;
    flexi_clock clk_1k(clk, 49_999, clk_1kHz);

    reg run_once_flag = 0;

    reg pb_released = 0;
    always @ (posedge clk_1kHz) begin
        if (complete_selection) begin
            complete_selection <= 0;
        end
        if (!active_flag) begin
            run_once_flag <= 0;
        end
        if (!run_once_flag) begin
            run_once_flag <= 1;
            if (prv_num == 0 || prv_num > 9 || prv_num < -9) begin
                row <= 3;
                col <= 1;
                selected_num <= 0;
            end
            else begin
                if (prv_num > 0) begin
                    row <= (prv_num - 1) / 3;
                    col <= (prv_num - 1) % 3;
                end
                else if (prv_num < 0) begin
                    row <= (-prv_num - 1) / 3;
                    col <= (-prv_num - 1) % 3;
                end
                selected_num <= prv_num;
            end
        end
        else if (btnU_db && pb_released && row > 0) begin
            row <= row - 1;
            pb_released <= 0;
        end
        else if (btnD_db && pb_released && row < 3) begin
            row <= row + 1;
            pb_released <= 0;
        end
        else if (btnL_db && pb_released && col > 0) begin
            col <= col - 1;
            pb_released <= 0;
        end
        else if (btnR_db && pb_released && col < 2) begin
            col <= col + 1;
            pb_released <= 0;
        end
        else if (btnC_db && pb_released && row == 3) begin
            pb_released <= 0;
            if (col == 2) begin
                complete_selection <= 1;
            end
            else if (col == 0) begin
                selected_num <= -selected_num;
            end
            else if (col == 1) begin
                selected_num <= 0;
            end
        end
        else if (btnC_db && pb_released && row != 3) begin
            pb_released <= 0;
            if (selected_num >= 0) begin
                selected_num <= 3 * row + col + 1;
            end
            else if (selected_num < 0) begin
                selected_num <= -(3 * row + col + 1);
            end
            else begin
                selected_num <= 0;
            end
        end
        else if (!btnC_db && !btnU_db && !btnL_db && !btnD_db && !btnR_db && !pb_released) begin
            pb_released <= 1;
        end
    end

endmodule
