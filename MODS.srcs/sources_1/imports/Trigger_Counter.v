`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2024 12:35:34
// Design Name: 
// Module Name: Trigger_Counter
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


module trigger_counter #(parameter COUNT = 300_000_000, BITWIDTH = 32, RESET_TRIGGER = 1'b0)
    (input clk, input enable_trigger, output reg trigger = 0);
    
    reg [BITWIDTH-1:0] counter = 0; // Tested & measured, should be correct
    
    // run either on clk(counting) or when switch turned off ()
    always @ (posedge clk) begin
        if (enable_trigger) begin
            counter <= counter + 1; 
            if (counter == COUNT - 1) begin // 3s delay
                trigger <= 1'b1;
            end
        end else begin // slight delay between restarting of the counter -> removed 
            counter <= 0;
            if (trigger == 1) begin
                trigger <= RESET_TRIGGER;
            end 
        end
    end
endmodule

