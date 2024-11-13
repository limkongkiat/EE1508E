`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2024 16:32:15
// Design Name: 
// Module Name: timer
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


module timer #(
    parameter [2:0] NUM_SECONDS = 3
    )(
    input clk,
    input reset,
    output reg [9:0] time_left = 10'd1000
    );

    reg [31:0] counter = NUM_SECONDS * 100_000 - 1;

    always @ (posedge clk) begin
        if (reset) begin
            time_left <= 10'd1000;
            counter <= NUM_SECONDS * 100_000 - 1;
        end else if (time_left == 0) begin
            // Do nothing
        end else begin
            if (counter == NUM_SECONDS * 100_000 - 1) begin
                counter <= 0;
            end else begin
                counter <= counter + 1;
            end

            if (counter == 0) begin
                time_left <= time_left - 1;
            end
        end
    end

endmodule
