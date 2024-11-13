`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2024 16:39:48
// Design Name: 
// Module Name: state_update_LR
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


module state_update_LR(
    input clk_1k,
    input pb_left, pb_right,
    input active_flag,
    input reset,
    input [2:0] STATE_COUNT,
    input [10:0] TIMER,
    output reg [2:0] state = 0
    );
    
    reg left_released = 0;
    reg right_released = 0;
    reg [2:0] temp = 0;
    reg [10:0] count = 0;

    always @ (posedge clk_1k)
    begin
        if (!reset)
        begin
            state <= 0; // reset state
        end
        else if (active_flag) begin
            if (state == STATE_COUNT) begin //1s timer for quirky business
                count <= count == TIMER ? 0 : count + 1;
                if (count == TIMER) begin
                    state <= temp;
                    temp <= 0;
                end
            end
            else begin
                if (pb_left && left_released) begin
                    left_released <= 0;
                    temp <= state == 0 ? STATE_COUNT - 1 : state - 1;
                    state <= STATE_COUNT;
                end
                else if (!pb_left && !left_released)
                    left_released <= 1;
                if (pb_right && right_released) begin
                    right_released <= 0;
                    temp <= state + 1 == STATE_COUNT ? 0 : state + 1;
                    state <= STATE_COUNT;
                end
                else if (!pb_right && !right_released)
                    right_released <= 1;
            end
        end
    end
    
endmodule
