`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2024 00:43:50
// Design Name: 
// Module Name: random_test
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


module random_test(

    );
    
    reg signed [4:0] test = 0;
    reg signed [4:0] test1 = 0;
    
    always begin
        #5 test = $urandom%10;
        test1 = $urandom%10;
    end
endmodule
