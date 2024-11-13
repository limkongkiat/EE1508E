`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2024 10:58:49
// Design Name: 
// Module Name: Matrix_Output_Selector_Box
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


module output_selector_box(input clk, input [6:0] x_coord, [5:0] y_coord,
    input active_flag,
    output reg is_box);

    parameter [5:0] OK_TOP_OFFSET = 56 - 2;
    parameter [6:0] OK_LEFT_OFFSET = 84 - 2;
    parameter [6:0] OK_BOX_LENGTH = 10 - 1 + 4;
    parameter [5:0] OK_BOX_HEIGHT = 5 + 4;

    wire clk_25MHz;
    flexi_clock clk_25M(clk, 1, clk_25MHz);

    wire delay_complete;
    trigger_counter #(.COUNT(100_000_000)) delay_1s
    (.clk(clk), .enable_trigger(active_flag), .trigger(delay_complete));

    always @ (posedge clk_25MHz) begin
        if (delay_complete) begin
            if ((x_coord >= OK_LEFT_OFFSET && x_coord <= OK_LEFT_OFFSET + OK_BOX_LENGTH - 1) &&
                (y_coord == OK_TOP_OFFSET || y_coord == OK_TOP_OFFSET + OK_BOX_HEIGHT - 1)) begin
                is_box <= 1;
            end
            else if ((y_coord >= OK_TOP_OFFSET && y_coord < OK_TOP_OFFSET + OK_BOX_HEIGHT) &&
                (x_coord == OK_LEFT_OFFSET || x_coord == OK_LEFT_OFFSET + OK_BOX_LENGTH - 1)) begin
                is_box <= 1;
            end
            else begin
                is_box <= 0;
            end
        end
        else begin
            is_box <= 0;
        end
    end
endmodule
