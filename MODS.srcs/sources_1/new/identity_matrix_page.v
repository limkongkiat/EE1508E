`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2024 10:55:11
// Design Name: 
// Module Name: identity_matrix_page
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


module diagonal_matrix_page(input clk, clk_6p25M, [12:0] pix_idx, [6:0] curr_x, [5:0] curr_y, 
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
    
    wire diag_desc;
    reg diag_anno [0:6143];
    reg scalar_anno [0:6143];
    reg iden_anno [0:6143];
    BRAM_diagonal m_bg (.clk(clk), .addr(pix_idx), .read_write(0), .data_in(0), .data_out(diag_desc));
    initial begin
        $readmemb("diag_anno.mem", diag_anno);
        $readmemb("scalar_anno.mem", scalar_anno);
        $readmemb("iden_anno.mem", iden_anno);
    end
    
    reg signed [4:0] a11 = 11; 
    reg signed [4:0] a22 = 11;
    reg signed [4:0] a33 = 11;

    wire [1:0] isMatrix;
    input_matrix_disp matrix(
    clk, curr_x , curr_y, 
    3, 3,
    a11, 0, 0,
    0, a22, 0, 
    0, 0, a33,
    isMatrix
    );

    wire [2:0] matrixState;

    state_update_LR matrixStateUpdate (
        .clk_1k(clk_1k),
        .pb_left(pb_left), .pb_right(pb_right),
        .active_flag(status),
        .reset(status),
        .STATE_COUNT(3),
        .TIMER(299),
        .state(matrixState)
    );
    
    reg [31:0] aniTimer = 0;
    always @ (posedge clk_10k) begin
        case (matrixState)
            0: begin
                {a11, a22, a33} <= {3{5'd10}};
                aniTimer <= 0;
            end
            1: begin
                {a11, a22, a33} <= {3{5'd11}};
                aniTimer <= 0;
            end
            2: begin
                {a11, a22, a33} <= {3{5'd1}};
                aniTimer <= 0;
            end
            3: begin
                aniTimer <= (aniTimer == 499) ? 0 : aniTimer + 1;
                if (aniTimer == 0) begin
                    a11 <= ((a22 + 3) & 5'b00111) + 1;
                    a22 <= ((a33 + 2) & 5'b00111) + 1;
                    a33 <= ((a11 + 1) & 5'b00111) + 1;
                end
            end
        endcase
    end
        
    reg [15:0] anno_disp = 0;
    always @ (posedge MHz25) begin
        case (matrixState)
            0: begin
                anno_disp <= diag_anno[curr_y * 96 + curr_x];
            end
            1: begin
                anno_disp <= scalar_anno[curr_y * 96 + curr_x];
            end
            2: begin
                anno_disp <= iden_anno[curr_y * 96 + curr_x];
            end
            3: begin
                anno_disp <= 0;
            end
        endcase
    end
    
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
    
    always @ (posedge MHz25) begin
        if (status == 0) begin
            oled_colour <= diag_desc  ? 16'b00000_111111_00000 : 0;
        end
        else begin
            if (isMatrix[1])
                oled_colour <= 16'b10000_111111_10000;
            else if (isMatrix[0])
                oled_colour <= 16'b00000_111111_00000;
            else 
                oled_colour <= anno_disp  ? 16'b00000_111111_00000 : 0;
        end
    end
endmodule
