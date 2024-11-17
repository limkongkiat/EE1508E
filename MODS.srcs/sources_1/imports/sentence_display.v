`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.10.2024 00:02:06
// Design Name: 
// Module Name: sentence_display
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


module sentence_display #(localparam NUM_QUESTIONS = 10)(
    input clk_25M,
    input active_flag,
    input [12:0] pix_idx,
    input [3:0] question_num,
    input pb_up, pb_down,
    output reg [15:0] word_screen = 16'b0
    );

    wire [(4 * NUM_QUESTIONS) - 1:0] question_row_count;
    assign question_row_count = {
        4'd5,  // Q10
        4'd9,  // Q9
        4'd6,  // Q8
        4'd7,  // Q7
        4'd10, // Q6
        4'd6,  // Q5
        4'd5,  // Q4
        4'd6,  // Q3
        4'd7,  // Q2
        4'd6   // Q1
    };

    wire [2:0] scroll_offset;
    text_scroll scroll (
        .clk25M(clk_25M),
        .active_flag(active_flag),
        .pb_up(pb_up), .pb_down(pb_down),
        .question_num(question_num),
        .question_row_count(question_row_count),
        .scroll_offset(scroll_offset)
    );
    
    reg [15:0] question_1 [0:2879];
    reg [15:0] question_2 [0:2879];
    reg [15:0] question_3 [0:3455];
    reg [15:0] question_4 [0:2303];
    reg [15:0] question_5 [0:2879];
    reg [15:0] question_6 [0:5183];
    reg [15:0] question_7 [0:3455];
    reg [15:0] question_8 [0:2879];
    reg [15:0] question_9 [0:4607];
    reg [15:0] question_10 [0:2303];
    initial begin
        $readmemh("Q1.mem", question_1);
        $readmemh("Q2.mem", question_2);
        $readmemh("Q3.mem", question_3);
        $readmemh("Q4.mem", question_4);
        $readmemh("Q5.mem", question_5);
        $readmemh("Q6.mem", question_6);
        $readmemh("Q7.mem", question_7);
        $readmemh("Q8.mem", question_8);
        $readmemh("Q9.mem", question_9);
        $readmemh("Q10.mem", question_10);
    end

    // below is 96 * 6 rows
    localparam [9:0] NUM_PIXELS_OFFSET = 576;

    always @ (posedge clk_25M) begin
        // Numbers used below are raw calcs from where header and buttons start. Don't ask.
        if (pix_idx >= 13'd960 && pix_idx < 13'd4416) begin
            case (question_num)
                // All calculated here rather than a reg cuz Vivado kept complaining about reg, initial value, and accessing BRAM or smth
                4'd0: word_screen <= question_1[(pix_idx - 13'd960) + scroll_offset * NUM_PIXELS_OFFSET];
                4'd1: word_screen <= question_2[(pix_idx - 13'd960) + scroll_offset * NUM_PIXELS_OFFSET];
                4'd2: word_screen <= question_3[(pix_idx - 13'd960) + scroll_offset * NUM_PIXELS_OFFSET];
                4'd3: word_screen <= question_4[(pix_idx - 13'd960) + scroll_offset * NUM_PIXELS_OFFSET];
                4'd4: word_screen <= question_5[(pix_idx - 13'd960) + scroll_offset * NUM_PIXELS_OFFSET];
                4'd5: word_screen <= question_6[(pix_idx - 13'd960) + scroll_offset * NUM_PIXELS_OFFSET];
                4'd6: word_screen <= question_7[(pix_idx - 13'd960) + scroll_offset * NUM_PIXELS_OFFSET];
                4'd7: word_screen <= question_8[(pix_idx - 13'd960) + scroll_offset * NUM_PIXELS_OFFSET];
                4'd8: word_screen <= question_9[(pix_idx - 13'd960) + scroll_offset * NUM_PIXELS_OFFSET];
                4'd9: word_screen <= question_10[(pix_idx - 13'd960) + scroll_offset * NUM_PIXELS_OFFSET];
            endcase
        end else begin
            word_screen <= 16'b0;
        end
    end
    
endmodule
