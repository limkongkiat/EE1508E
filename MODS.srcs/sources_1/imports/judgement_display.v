`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2024 13:37:18
// Design Name: 
// Module Name: judgement_display
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


module judgement_display(
    input clk_25M,
    input active_flag,
    input [12:0] pix_idx,
    input correct,
    output reg [15:0] judgement_screen = 16'b0
    );

    reg [15:0] correct_screen [0:6143];
    reg [15:0] wrong_screen [0:6143];
    initial begin
        $readmemh("Yes.mem", correct_screen);
        $readmemh("No.mem", wrong_screen);
    end

    always @ (posedge clk_25M) begin
        if (active_flag) begin
            if (correct) begin
                judgement_screen <= correct_screen[pix_idx];
            end else begin
                judgement_screen <= wrong_screen[pix_idx];
            end
        end
    end

endmodule
