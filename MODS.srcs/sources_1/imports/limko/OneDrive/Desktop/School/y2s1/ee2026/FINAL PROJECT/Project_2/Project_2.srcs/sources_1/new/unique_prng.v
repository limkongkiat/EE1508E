`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2024 17:10:39
// Design Name: 
// Module Name: unique_prng
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


module unique_prng(
    input clk,
    input update_ready, // says when it is safe to update rand_num
    output reg [3:0] rand_num = 4'd5
);
    reg [3:0] lfsr = 4'd0;
    reg [3:0] next_rand_num = 4'd5;

    always @ (posedge clk) begin
        // Formula for max-length LFSR taken from https://docs.amd.com/v/u/en-US/xapp052
        lfsr <= {lfsr[2:0], lfsr[3] ^~ lfsr[2]};
    end

    reg update_ready_prev = 1;
    always @ (posedge clk) begin
        update_ready_prev <= update_ready;

        if (rand_num != lfsr && lfsr < 4'd10)
            next_rand_num <= lfsr;

        if (update_ready && !update_ready_prev)
            rand_num <= next_rand_num;
    end
    
endmodule
