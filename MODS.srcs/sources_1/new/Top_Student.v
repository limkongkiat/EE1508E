`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: TAN YI SOONG NATHAN
//  STUDENT B NAME: CHENG TZE YONG
//  STUDENT C NAME: LIM KONG KIAT
//  STUDENT D NAME: LIM WEI MING BENJAMIN
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (input clk, btnU, btnD, btnC, btnL, btnR, [15:0] sw,
    inout PS2Clk, inout PS2Data, 
    output [15:0] led, output [7:0] JC);

    wire fb, send_pix, samp_pix;
    wire [12:0] pix_idx;
    reg [15:0] oled_colour = 0;
    
    wire MHz6p25;
    flexi_clock clk_6p25MHz (clk, 7, MHz6p25);
    wire clk_1k;
    flexi_clock clk_1kHz (.basys_clk(clk), .my_m_value(49_999), .my_clk(clk_1k));
    wire MHz25;
    flexi_clock clk_25MHz (.basys_clk(clk), .my_m_value(1), .my_clk(MHz25));
    
    Oled_Display(.clk(MHz6p25), .reset(0), .frame_begin(fb), .sending_pixels(send_pix),
      .sample_pixel(samp_pix), .pixel_index(pix_idx), .pixel_data(oled_colour), .cs(JC[0]), .sdin(JC[1]), .sclk(JC[3]), .d_cn(JC[4]), .resn(JC[5]), .vccen(JC[6]),
      .pmoden(JC[7]));
    
    wire pb_left, pb_right, pb_down, pb_up, pb_centre;
    switch_debouncing debounce1(.clk_1k(clk_1k), .pb(btnD), .press_detected(pb_down));
    switch_debouncing debounce2(.clk_1k(clk_1k), .pb(btnU), .press_detected(pb_up));
    switch_debouncing debounce3(.clk_1k(clk_1k), .pb(btnC), .press_detected(pb_centre));
    switch_debouncing debounce4(.clk_1k(clk_1k), .pb(btnL), .press_detected(pb_left));
    switch_debouncing debounce5(.clk_1k(clk_1k), .pb(btnR), .press_detected(pb_right));
    
    wire [6:0] curr_x;
    assign curr_x = pix_idx % 96;
    wire [5:0] curr_y;
    assign curr_y = pix_idx / 96;
    
    reg [4:0] arrowX = 22;
    reg [5:0] arrowHeight = 27;
    reg [2:0] pageState = 0;
    wire [2:0] arrowState;
    state_update_LR matrixStateUpdate (
        .clk_1k(clk_1k),
        .pb_left(pb_up), .pb_right(pb_down),
        .active_flag(~sw[15] && pageState == 0),
        .reset(1),
        .STATE_COUNT(4),
        .TIMER(0),
        .state(arrowState)
    );
    
    wire pillFlag;

    always @ (posedge MHz25) begin
        if (pillFlag)
            pageState <= 6;
        else if (sw[15] == 1) begin
            pageState <= 0;
        end
        else begin
            case (arrowState)
                0: begin
                    arrowX <= 22;
                    arrowHeight <= 27;
                    if (pb_centre) pageState <= 1;
                end
                1: begin
                    arrowX <= 11;
                    arrowHeight <= 35;
                    if (pb_centre) pageState <= 2;
                end
                2: begin
                    arrowX <= 11;
                    arrowHeight <= 43;
                    if (pb_centre) pageState <= 3;
                end
                3: begin 
                    arrowX <= 31;
                    arrowHeight <= 51;
                    if (pb_centre) pageState <= 4;
                end
            endcase
        end
    end
    
    wire bullet_time;
    assign bullet_time = sw[14:0] == 15'b000000100100011;
    
    wire [15:0] oled_main;
    main_menu MM(.clk(clk), .bullet_time(bullet_time), .MHz6p25(MHz6p25), .pix_idx(pix_idx), .curr_x(curr_x), .curr_y(curr_y), 
        .arrowX(arrowX), .arrowHeight(arrowHeight),
        .oled_main(oled_main));
    
    wire [15:0] oled_mult;
     multiply_matrix_subtask multiply_task(.clk(clk),
        .btnU_db(pb_up), .btnL_db(pb_left), .btnD_db(pb_down), .btnR_db(pb_right), .btnC_db(pb_centre),
        .pix_index(pix_idx), .active_flag(pageState == 1),
        .oled_colour(oled_mult), .exit_flag());
    
    wire [15:0] oled_det;
    calculate_determinant_subtask det_task(.clk(clk),
        .btnU_db(pb_up), .btnL_db(pb_left), .btnD_db(pb_down), .btnR_db(pb_right), .btnC_db(pb_centre),
        .pix_index(pix_idx), .active_flag(pageState == 2),
        .oled_colour(oled_det), .exit_flag(), .pillFlag(pillFlag));
        
    wire [15:0] oled_spM;
    sp_matrix_main sp(.clk(clk), .clk_6p25M(MHz6p25), .pix_idx(pix_idx), .curr_x(curr_x), .curr_y(curr_y), 
        .pb_up(pb_up), .pb_down(pb_down), .pb_left(pb_left), .pb_right(pb_right), .isActive(pageState == 3),
        .oled_colour(oled_spM));
        
    wire [15:0] oled_quiz;
    quiz quiz_module (
        .clk(clk),
        .active_flag(pageState == 4),
        .btnC(btnC), .btnU(btnU), .btnL(btnL), .btnR(btnR), .btnD(btnD), 
        .pix_idx(pix_idx),
        .oled_colour(oled_quiz)
    );
    
    wire [15:0] escaped_page;
    BRAM_escaped pil (.clk(clk), .addr(pix_idx), .read_write(0), .data_in(0), .data_out(escaped_page));
    
    always @ (MHz25) begin
        case (pageState)
            1: oled_colour <= oled_mult;
            2: oled_colour <= oled_det;
            3: oled_colour <= oled_spM;
            4: oled_colour <= oled_quiz;
            6: oled_colour <= escaped_page;
            default: oled_colour <= oled_main;
        endcase
    end
    
    assign led = !pageState && bullet_time ? 16'b0000_0001_0010_0011 : 0;

endmodule