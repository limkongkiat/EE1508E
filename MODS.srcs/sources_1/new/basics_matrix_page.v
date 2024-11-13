`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2024 23:31:35
// Design Name: 
// Module Name: basics_matrix_page
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


module basics_matrix_page(input clk, clk_6p25M, [12:0] pix_idx, [6:0] curr_x, [5:0] curr_y, 
    input pb_up, pb_down, pb_left, pb_right,
    input isActive,
    output reg [15:0] oled_colour,
    output reg status = 0);
    
    wire clk_1k;
    flexi_clock clk_1kHz (.basys_clk(clk), .my_m_value(49_999), .my_clk(clk_1k));
    wire clk_10k;
    flexi_clock clk_10kHz (.basys_clk(clk), .my_m_value(4_999), .my_clk(clk_10k));
    wire MHz25;
    flexi_clock clk_25MHz (.basys_clk(clk), .my_m_value(1), .my_clk(MHz25));

    wire basics_desc;
    reg basics_anno [0:6143];
    BRAM_basics Bb (.clk(clk), .addr(pix_idx), .read_write(0), .data_in(0), .data_out(basics_desc));
    initial begin
        $readmemb("basic_anno.mem", basics_anno);
    end

    wire [1:0] isMatrix;
    input_matrix_disp matrix(
    clk, curr_x , curr_y, 
    2, 3,
    10, 10, 10,
    10, 10, 10,
    15, 15, 15,
    isMatrix
    );
    
    always @ (posedge clk_10k) begin
        if (isActive) begin
            if (status == 0 && pb_down)
                status <= 1;
            else if (status == 1 && pb_up)
                status <= 0;
        end
        else
            status <= 0;
    end
    
    wire isAnno;
    basic_mat_anno anno(
        .clk_25MHz(MHz25), .curr_x(curr_x), .curr_y(curr_y), 
        .isAnno(isAnno)
    );
    
    always @ (posedge MHz25) begin
        if (status == 0) begin
            oled_colour <= basics_desc ? 16'b00000_111111_00000 : 0;
        end
        else begin
            if (isMatrix[1])
                oled_colour <= 16'b10000_111111_10000;
            else if (isMatrix[0])
                oled_colour <= 16'b00000_111111_00000;
            else if (isAnno)
                oled_colour <= 16'b10000_111111_10000;
            else 
                oled_colour <= basics_anno[pix_idx] ? 16'b00000_111111_00000 : 0;
        end
    end
endmodule
