`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2024 12:20:41
// Design Name: 
// Module Name: Top_Test
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


module Top_Test(input clk, btnU, btnD, btnC, btnL, btnR, [15:0] sw,
    inout PS2Clk, inout PS2Data, 
    output [15:0] led, output [7:0] JC);
            
//wire xpos; wire ypos; wire zpos; wire left; wire middle; wire right; wire new_event;

//led_control ledctrl (clk, left, middle, right, led);
//MouseCtl mouse (.clk(clk), .rst(0), 
//            .xpos(xpos), .ypos(ypos), .zpos(zpos), .left(left), .middle(middle), .right(right), .new_event(new_event), .value(0), .setx(0), .sety(0), .setmax_x(0), .setmax_y(0),
//            .ps2_clk(PS2Clk), .ps2_data(PS2Data));

    wire fb, send_pix, samp_pix;
    wire [12:0] pix_idx;
    wire [15:0] oled_colour;
    
    wire MHz6p25;
    flexi_clock clk_6p25MHz (clk, 7, MHz6p25);
    wire clk_1k;
    flexi_clock clk_1kHz (.basys_clk(clk), .my_m_value(49_999), .my_clk(clk_1k));
    wire clk_1;
    flexi_clock clk_1Hz (.basys_clk(clk), .my_m_value(49_999_999), .my_clk(clk_1));
    wire MHz25;
    flexi_clock clk_25MHz (.basys_clk(clk), .my_m_value(1), .my_clk(MHz25));
    
    Oled_Display(.clk(MHz6p25), .reset(0), .frame_begin(fb), .sending_pixels(send_pix),
      .sample_pixel(samp_pix), .pixel_index(pix_idx), .pixel_data(oled_colour), .cs(JC[0]), .sdin(JC[1]), .sclk(JC[3]), .d_cn(JC[4]), .resn(JC[5]), .vccen(JC[6]),
      .pmoden(JC[7]));
      
      wire curr_x, curr_y;
      assign curr_x = pix_idx % 96;
      assign curr_y = pix_idx / 96;
      reg signed [4:0] counter = 0;
      wire isOrderNum;
      signed_dig_disp sdd(
          .clk(MHz25), .curr_x(curr_x), .curr_y(curr_y), 
          .left_x(37), .top_y(2), .scale(2), .digit(counter), 
          .isDigit(isOrderNum));
          
      always @ (posedge clk_1) begin
        counter <= (counter == 9) ? -9 : counter + 1;
      end
      
      assign oled_colour = isOrderNum ? 16'h07e0 : 16'hffff;
      
endmodule
