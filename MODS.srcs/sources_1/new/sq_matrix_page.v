`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2024 18:39:47
// Design Name: 
// Module Name: sq_matrix_page
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


module sq_matrix_page(input clk, clk_6p25M, [12:0] pix_idx, [6:0] curr_x, [5:0] curr_y, 
    input pb_up, pb_down, pb_left, pb_right,
    input isActive,
    output reg [15:0] oled_colour,
    output reg status = 0);

    wire clk_1k;
    flexi_clock clk_1kHz (.basys_clk(clk), .my_m_value(49_999), .my_clk(clk_1k));
    wire clk_10k;
    flexi_clock clk_10kHz (.basys_clk(clk), .my_m_value(4_999), .my_clk(clk_10k));
    
    reg sq_anno [0:6143];
    initial begin
        $readmemb("sq_anno.mem",sq_anno);
    end          
    
    wire sq_desc;
    BRAM_square Bb (.clk(clk), .addr(pix_idx), .read_write(0), .data_in(0), .data_out(sq_desc));

    wire MHz25;
    flexi_clock clk_25MHz (.basys_clk(clk), .my_m_value(1), .my_clk(MHz25));

    reg signed [4:0] ord2 = 15;
    reg signed [4:0] ord3 = 15;

    wire [2:0] matrixState;
    state_update_LR matrixStateUpdate (
        .clk_1k(clk_10k),
        .pb_left(pb_left), .pb_right(pb_right),
        .active_flag(status),
        .reset(status),
        .STATE_COUNT(3),
        .TIMER(0),
        .state(matrixState)
    );
    
    wire [1:0] isMatrix;
    input_matrix_disp or1(
        clk, curr_x , curr_y, 
        matrixState + 1, matrixState + 1,
        10, ord2, ord3,
        ord2, ord2, ord3,
        ord3, ord3, ord3,
        isMatrix
    );
    
    always @ (posedge MHz25) begin
        case (matrixState)
            0: begin
                ord2 <= 15;
                ord3 <= 15;
            end
            1: begin
                ord2 <= 10;
                ord3 <= 15;
            end
            2: begin
                ord2 <= 10;
                ord3 <= 10;
            end
            default: begin
                ord2 <= ord2;
                ord3 <= ord3;
            end
        endcase
    end
    
    /*--annotation--*/
//    wire [79:0] orderAnno;
//    assign orderAnno = reverse_bits({spc,spc,spc,spc,O,R,D,E,R,colon,spc,spc,spc,spc,spc,spc});

//    wire isOrderAnno;
//    row_display rd(
//        .clk_6p25M(clk_6p25M), .clk_25M(MHz25),
//        .start_y(2),
//        .x_pos(curr_x), .y_pos(curr_y),
//        .sentence(orderAnno), // 16 characters width max
//        .isLetter(isOrderAnno)
//    );

    wire isOrderNum;
    signed_dig_disp sdd(
        .clk(MHz25), .curr_x(curr_x), .curr_y(curr_y), 
        .left_x(37), .top_y(2), .scale(1), .digit(matrixState + 1), 
        .isDigit(isOrderNum));
    /*--annotation--*/
    
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
            oled_colour <= sq_desc ? 16'b00000_111111_00000 : 0;
        end
        else begin
            if (isMatrix[1])
                oled_colour <= 16'b10000_111111_10000;
            else if (isOrderNum || isMatrix[0])
                oled_colour <= 16'b00000_111111_00000;
            else
                oled_colour <= sq_anno[pix_idx] ? 16'b00000_111111_00000 : 0;
        end
    end
endmodule
