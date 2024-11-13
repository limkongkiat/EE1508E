`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2024 15:29:41
// Design Name: 
// Module Name: BRAM_mult_size_r1
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


module BRAM_mult_size_r2#(parameter filename = "Multiply_Size_Background_R2.mem",
    parameter n = 13,
    parameter w = 16) 
    (clk, addr, read_write, data_in, data_out);

    input clk, read_write;
    input [n-1:0] addr;
    input [w-1:0] data_in;
    output reg [w-1:0] data_out;

    // Start module here!
    reg [w-1:0] reg_array [0:6143];

    initial begin
        $readmemh(filename, reg_array);
    end

    always @(posedge(clk)) begin
        if(read_write == 1)
            reg_array[addr] <= data_in;
        data_out = reg_array[addr];
    end
endmodule