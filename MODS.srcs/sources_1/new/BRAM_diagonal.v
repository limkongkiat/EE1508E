`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2024 21:29:33
// Design Name: 
// Module Name: BRAM_diagonal
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


module BRAM_diagonal#(parameter filename = "diagonal_page.mem",
    parameter n = 13) 
    (clk, addr, read_write, data_in, data_out);

    input clk, read_write;
    input [n-1:0] addr;
    input data_in;
    output reg data_out;

    // Start module here!
    reg reg_array [0:6143];

    initial begin
        $readmemb(filename, reg_array);
    end

    always @(posedge(clk)) begin
        if(read_write == 1)
            reg_array[addr] <= data_in;
        data_out = reg_array[addr];
    end
endmodule
