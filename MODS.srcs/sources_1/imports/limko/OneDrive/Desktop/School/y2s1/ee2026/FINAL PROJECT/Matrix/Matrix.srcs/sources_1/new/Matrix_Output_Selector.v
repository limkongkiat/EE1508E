`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2024 10:58:49
// Design Name: 
// Module Name: Matrix_Output_Selector
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


module output_selector(input clk, btnC_db,
    input active_flag, output reg complete_selection = 0);

    wire clk_1kHz;
    flexi_clock clk_1k(clk, 49_999, clk_1kHz);

    wire delay_complete;
    trigger_counter #(.COUNT(100_000_000)) delay_1s
    (.clk(clk), .enable_trigger(active_flag), .trigger(delay_complete));

    reg pb_released = 0;

    always @ (posedge clk_1kHz) begin
        if (!active_flag) begin
            complete_selection <= 0;
            pb_released = 0;
        end
        if (btnC_db && pb_released && delay_complete) begin
            pb_released <= 0;
            complete_selection <= 1;
        end
        else if (!btnC_db && !pb_released) begin
            pb_released <= 1;
        end
    end
endmodule
