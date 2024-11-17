`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2024 03:20:13 PM
// Design Name: 
// Module Name: Multiplication_2x2_2x2
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


module multiplication_2x2_2x2(
    input clk, input signed [4:0] a11, a12, a21, a22, 
    input signed [4:0] b11, b12, b21, b22, 
    input [1:0] m1_rows, m1_cols, m2_rows, m2_cols, 
    output reg signed [8:0] c11, c12, c21, c22);

    wire clk_25MHz;
    flexi_clock clk_25M(clk, 1, clk_25MHz);
    
     wire signed [8:0] mult_result[0:7]; // Wires for storing mult_gen results
   
       // Instantiate mult_gen modules for all required multiplications
       mult_gen mult00 (.A(a11), .B(b11), .P(mult_result[0])); // a11 * b11
       mult_gen mult01 (.A(a12), .B(b21), .P(mult_result[1])); // a12 * b21
       mult_gen mult02 (.A(a11), .B(b12), .P(mult_result[2])); // a11 * b12
       mult_gen mult03 (.A(a12), .B(b22), .P(mult_result[3])); // a12 * b22
       mult_gen mult04 (.A(a21), .B(b11), .P(mult_result[4])); // a21 * b11
       mult_gen mult05 (.A(a22), .B(b21), .P(mult_result[5])); // a22 * b21
       mult_gen mult06 (.A(a21), .B(b12), .P(mult_result[6])); // a21 * b12
       mult_gen mult07 (.A(a22), .B(b22), .P(mult_result[7])); // a22 * b22
   
       always @(posedge clk_25MHz) begin
           // Initialize outputs
           c11 = 0; c12 = 0; c21 = 0; c22 = 0;
   
           // Implement matrix multiplication using mult_gen results
           if (m1_rows == 1 && m1_cols == 1 && m2_rows == 1 && m2_cols == 1) begin // 1x1 & 1x1
               c11 = mult_result[0];
           end
           else if (m1_rows == 1 && m1_cols == 2 && m2_rows == 2 && m2_cols == 1) begin // 1x2 & 2x1
               c11 = mult_result[0] + mult_result[1];
           end
           else if (m1_rows == 2 && m1_cols == 1 && m2_rows == 1 && m2_cols == 2) begin // 2x1 & 1x2
               c11 = mult_result[0];
               c12 = mult_result[2];
               c21 = mult_result[4];
               c22 = mult_result[6];
           end
           else if (m1_rows == 2 && m1_cols == 2 && m2_rows == 2 && m2_cols == 2) begin // 2x2 & 2x2
               c11 = mult_result[0] + mult_result[1];
               c12 = mult_result[2] + mult_result[3];
               c21 = mult_result[4] + mult_result[5];
               c22 = mult_result[6] + mult_result[7];
           end
           else if (m1_rows == 1 && m1_cols == 1 && m2_rows == 1 && m2_cols == 2) begin // 1x1 & 1x2
               c11 = mult_result[0];
               c12 = mult_result[2];
           end
           else if (m1_rows == 1 && m1_cols == 2 && m2_rows == 2 && m2_cols == 2) begin // 1x2 & 2x2
               c11 = mult_result[0] + mult_result[1];
               c12 = mult_result[2] + mult_result[3];
           end
           else if (m1_rows == 2 && m1_cols == 1 && m2_rows == 1 && m2_cols == 1) begin // 2x1 & 1x1
               c11 = mult_result[0];
               c21 = mult_result[4];
           end
           else if (m1_rows == 2 && m1_cols == 2 && m2_rows == 2 && m2_cols == 1) begin // 2x2 & 2x1
               c11 = mult_result[0] + mult_result[1];
               c21 = mult_result[4] + mult_result[5];
           end
       end
   endmodule

