`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2024 22:51:10
// Design Name: 
// Module Name: quiz
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


module quiz(
    input clk,
    input active_flag,
    input btnC, btnU, btnL, btnR, btnD,
    input [12:0] pix_idx,
    output [15:0] oled_colour
    );

    wire clk_25M;
    flexi_clock clk_25MHz (.basys_clk(clk), .my_m_value(3), .my_clk(clk_25M));
    
    wire clk_1k;
    flexi_clock clk_1kHz (.basys_clk(clk), .my_m_value(49_999), .my_clk(clk_1k));
    
    wire pb_centre; wire pb_up; wire pb_left; wire pb_right; wire pb_down;
    switch_debouncing pbC (.clk_1k(clk_1k), .pb(btnC), .press_detected(pb_centre));
    switch_debouncing pbU (.clk_1k(clk_1k), .pb(btnU), .press_detected(pb_up));
    switch_debouncing pbL (.clk_1k(clk_1k), .pb(btnL), .press_detected(pb_left));
    switch_debouncing pbR (.clk_1k(clk_1k), .pb(btnR), .press_detected(pb_right));
    switch_debouncing pbD (.clk_1k(clk_1k), .pb(btnD), .press_detected(pb_down));
    
    wire [6:0] x_pos; wire [5:0] y_pos;
    index_to_xy xy (.clk(clk_25M), .pix_idx(pix_idx), .x(x_pos), .y(y_pos));

    // question_num and score is being driven below in always block
    reg [3:0] question_num = 0; // Tracks current question number (not the one in question_bank)
    reg [3:0] score = 0; // track current score
    wire isHeader;
    header_display head_disp (
        .clk_25M(clk_25M),
        .x_pos(x_pos), .y_pos(y_pos),
        .question_num(question_num),
        .score(score),
        .isHeader(isHeader)
    );
    
    // wire isLetter;
    wire [15:0] word_screen;
    wire [3:0] rand_question; // driven by prng
    sentence_display word_disp (
        .clk_25M(clk_25M), 
        .active_flag(active_flag),
        .pix_idx(pix_idx),
        .question_num(rand_question),
        .pb_up(pb_up), .pb_down(pb_down),
        .word_screen(word_screen)
    );

    wire [15:0] button_colour;
    wire isTrueButton; wire isFalseButton;
    wire left_selected; wire right_selected; // handled in main always block below
    buttons_display buttons (
        .clk_25M(clk_25M),
        .x_pos(x_pos), .y_pos(y_pos),
        .isTrueButton(isTrueButton), .isFalseButton(isFalseButton)
    );

    reg update_prng = 0; // driven in main always block below
    unique_prng prng (
        .clk(clk_1k),
        .update_ready(update_prng),
        .rand_num(rand_question)
    );

    // BIG endian, finally.
    localparam [0:0] TRUE = 1'b1; localparam [0:0] FALSE = 1'b0;
    parameter [0:9] correct_answers = {
        TRUE,  // Q1
        FALSE,
        FALSE,
        FALSE,
        FALSE,
        TRUE,
        TRUE,
        TRUE,
        FALSE,
        TRUE   // Q10
    };

    reg correct = FALSE; // Track if the most recent answer was correct

    // displays correct/wrong screen after each question
    wire [15:0] judgement_screen;
    judgement_display judgement_display_screen (
        .clk_25M(clk_25M),
        .active_flag(active_flag),
        .pix_idx(pix_idx),
        .correct(correct),
        .judgement_screen(judgement_screen)
    );

    wire [15:0] score_screen;
    wire isCurrentScore;
    results_display results_screen (
        .clk_25M(clk_25M),
        .pix_idx(pix_idx),
        .x_pos(x_pos), .y_pos(y_pos),
        .curr_score(score),
        .results_screen(score_screen),
        .isCurrentScore(isCurrentScore)
    );

    reg reset_timer = 0; // driven in main always block below
    reg blink = 0; // driven in main always block below
    wire [9:0] time_left;
    timer #(.NUM_SECONDS(3'd1)) timer_1s (
        .clk(clk),
        .reset(reset_timer),
        .time_left(time_left)
    );

    parameter [1:0] DISPLAY_QUESTION = 2'b00;
    parameter [1:0] DISPLAY_ANSWER = 2'b01;
    parameter [1:0] NEXT_QUESTION = 2'b10;
    parameter [1:0] RESULTS_SCREEN = 2'b11;

    reg [1:0] current_state = DISPLAY_QUESTION;

    wire input_done;
    answer_logic quiz_ans_logic (
        .clk_25M(clk_25M),
        .active_flag(active_flag && !current_state),
        .left_button(pb_left), .right_button(pb_right), .centre_button(pb_centre),
        .left_selected(left_selected), .right_selected(right_selected), .input_done(input_done)
    );

    reg pb_centre_prev = 0;
    // state handler
    always @ (posedge clk_25M) begin
        pb_centre_prev <= pb_centre;

        if (!active_flag) begin
            correct <= 0; // idk? just reset it ig
            question_num <= 0;
            score <= 0;
            reset_timer <= 0;
            update_prng <= 0;
            current_state <= DISPLAY_QUESTION;
        end else begin
            case (current_state)
                DISPLAY_QUESTION: begin
                    if (input_done) begin
                        // Compare user's answer to the correct answer
                        if (left_selected == correct_answers[rand_question]) begin
                            correct <= 1;
                            score <= score + 1; // Increment score for correct answer
                        end else begin
                            correct <= 0;
                        end
                        
                        current_state <= DISPLAY_ANSWER; // Go to feedback screen
                        reset_timer <= 1; // start timer for feedback screen
                    end
                end
                DISPLAY_ANSWER: begin
                    reset_timer <= 0; // stop resetting lmfao
                    update_prng <= 1;

                    // Control blinking
                    if (time_left <= 925 && time_left > 850) begin
                        blink <= 0;
                    end else begin
                        blink <= 1;
                    end

                    if (time_left == 0) begin
                        question_num <= question_num + 1;
                        update_prng <= 0;
                        current_state <= NEXT_QUESTION;
                    end
                end
                NEXT_QUESTION: begin
                    if (question_num < 5) begin
                        current_state <= DISPLAY_QUESTION;
                    end else begin
                        // End of quiz, go to result screen or reset
                        current_state <= RESULTS_SCREEN;
                    end
                end
                RESULTS_SCREEN: begin
                    if (pb_centre && !pb_centre_prev) begin
                        question_num <= 0;
                        score <= 0;
                        current_state <= DISPLAY_QUESTION;
                    end
                end
            endcase
        end
    end
        
    oled_driver oled (
        .clk_25M(clk_25M),
        .active_flag(active_flag),
        .current_state(current_state),
        .isHeader(isHeader), .isTrueButton(isTrueButton), .isFalseButton(isFalseButton),
        .score_screen(score_screen), .isCurrentScore(isCurrentScore),
        .isHoverLeftRight({right_selected, left_selected}),
        .word_screen(word_screen),
        .blink(blink), .judgement_screen(judgement_screen),
        .oled_colour(oled_colour)
    );

endmodule
