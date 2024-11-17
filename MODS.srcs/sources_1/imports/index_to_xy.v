`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2024 23:10:59
// Design Name: 
// Module Name: index_to_xy
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


module index_to_xy(
    input clk,
    input [12:0] pix_idx,
    // oled is 96 by 64
    output reg [6:0] x = 0, reg [5:0] y = 0
//    output [6:0] x, [5:0] y
    );
    
    always @ (posedge clk) begin
// //        x <= (pix_idx + 1) % 96;
    
// //        if (pix_idx == 6143) 
// //            y <= (pix_idx / 96) + 1;
// //        else 
// //            y <= pix_idx / 96;
        x <= pix_idx % 96;
        y <= pix_idx / 96;
    end

//    assign x = (pix_idx + 1) % 96;
//    // y wraps exactly, so abuse wrapping around in edge case of pixel 6143
//    assign y = (pix_idx + 1 == 0) ? (pix_idx / 96) + 1 : pix_idx / 96;

    // Illegal hacky method to reduce LUT usage
    // relies on the fact that we are clocking oled at this exact clocking speed
    // Ok I massively underestimated Oled_Display module, below completely doesn't work. knn. 
    // always @ (posedge clk_6p25M) begin
    //     if (pix_idx == 0) begin
    //         x = 0;
    //         y = 0;
    //     end else begin
    //         if (x == 95) begin
    //             x = 0;
    //             y = y + 1;
    //         end else begin
    //             x = x + 1;
    //         end
    //     end
    // end
    
endmodule
