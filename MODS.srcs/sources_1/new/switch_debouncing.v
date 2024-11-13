`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2024 11:27:23
// Design Name: 
// Module Name: switch_debouncing
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


module switch_debouncing(
    input clk_1k,
    input pb, // pushbutton
    output reg press_detected = 0
    );
    
    reg debounce_active = 0;
    reg [31:0] count = 0;
    
    always @ (posedge clk_1k)
    begin
        // detect press, start debounce
        if (press_detected == 0 && pb == 1 && !debounce_active)
        begin
            press_detected <= 1;
            debounce_active <= 1;
        end

        // 200ms debounce timer
        if (debounce_active)
        begin
            count <= count == 200 ? 0 : count + 1;
            debounce_active <= count == 200 ? 0 : debounce_active;
        end
        
        // detect let go, reset press_detected variable
        if (press_detected == 1 && pb == 0 && !debounce_active)
        begin
            press_detected <= 0; // reset press_detected only if button let go
        end
    end
    
endmodule
