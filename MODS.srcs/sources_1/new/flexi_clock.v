`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2024 09:20:47
// Design Name: 
// Module Name: flexi_clock
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


module flexi_clock(
    input basys_clk, [31:0] my_m_value,
    output reg my_clk = 0
    );
    
    reg [31:0] count = 0;
    
    always @ (posedge basys_clk)
    begin
        count <= count == my_m_value ? 0 : count + 1;
        my_clk <= count == 0 ? ~my_clk : my_clk;
    end
    
endmodule
