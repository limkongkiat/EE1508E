`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2024 03:45:28 PM
// Design Name: 
// Module Name: Process_Result
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


module process_result(input signed [8:0] result, output signed [4:0] result_hundreds, output signed [4:0] result_tens, output signed [4:0] result_ones);

    wire signed [8:0] abs_result; 
    assign abs_result = (result < 0) ? -result : result;

    assign result_hundreds = (abs_result >= 100) ? (result < 0 ? result / 100 : abs_result / 100) : (result < 0 ? 14 : 0);                          
    assign result_tens = (abs_result / 10) % 10;
    assign result_ones = abs_result % 10;


endmodule
