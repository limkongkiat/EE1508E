`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2024 00:04:17
// Design Name: 
// Module Name: answer_logic
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


module answer_logic(
    input clk_25M,
    input active_flag,
    input left_button, input right_button, input centre_button,
    output reg left_selected = 0, output reg right_selected = 0, output reg input_done = 0
);

    parameter [1:0] IDLE         = 2'b00;
    parameter [1:0] HOVER_TRUE   = 2'b01;
    parameter [1:0] HOVER_FALSE  = 2'b10;
    parameter [1:0] ANSWER_INPUT = 2'b11;
    
    reg [1:0] current_state = IDLE;

    reg left_button_prev = 0;
    reg right_button_prev = 0;
    reg centre_button_prev = 0;

    // Edge detection signals to act as push buttons
    wire left_button_edge; wire right_button_edge; wire centre_button_edge;

    assign left_button_edge = left_button & ~left_button_prev;
    assign right_button_edge = right_button & ~right_button_prev;
    assign centre_button_edge = centre_button & ~centre_button_prev;
    
    always @ (posedge clk_25M) begin
        if (!active_flag) begin
            left_selected = 0;
            right_selected = 0;
            input_done = 0;
            current_state = IDLE;
        end else begin
            // Update prev button states
            left_button_prev <= left_button;
            right_button_prev <= right_button;
            centre_button_prev <= centre_button;

            case (current_state)
                IDLE: begin
                    // if (left_button_edge || centre_button_edge)
                    if (left_button_edge)
                        current_state = HOVER_TRUE;
                    else if (right_button_edge)
                        current_state = HOVER_FALSE;
                    else // kinda unneccessary, but more readable kinda
                        current_state = IDLE;
                end
                HOVER_TRUE: begin
                    left_selected = 1;
                    right_selected = 0;
                    if (centre_button_edge) begin
                        input_done = 1; // Finalize input
                        current_state = ANSWER_INPUT;
                    end else if (right_button_edge) begin
                        current_state = HOVER_FALSE;
                    end
                end
                HOVER_FALSE: begin
                    right_selected = 1;
                    left_selected = 0;
                    if (centre_button_edge) begin
                        input_done = 1; // Finalize input
                        current_state = ANSWER_INPUT;
                    end else if (left_button_edge) begin
                        current_state = HOVER_TRUE;
                    end
                end
                ANSWER_INPUT: begin
                    // reset
                    current_state = IDLE;
                    left_selected = 0;
                    right_selected = 0;
                    input_done = 0;
                end
            endcase
        end
    end
endmodule
