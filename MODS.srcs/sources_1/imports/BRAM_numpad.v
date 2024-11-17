`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2024 15:04:55
// Design Name: 
// Module Name: BRAM_numpad
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


module BRAM_numpad#(parameter filename = "Numpad_Background.mem",
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
