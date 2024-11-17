`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2024 17:19:13
// Design Name: 
// Module Name: Parse_Digits_Det
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


module parse_digits(input clk, reset, input signed [15:0] value,
    output reg [3:0] digit_1, digit_2, digit_3, digit_4, output reg polarity);
    
    reg [2:0] digit_pos; 
    reg state;
    reg signed [15:0] temp_value;
    
    wire clk_25MHz;
    flexi_clock clk_25M(clk, 1, clk_25MHz);
    
    always @(posedge clk_25MHz) begin
        if (reset) begin
            // Reset all values
            digit_pos <= 3;
            state <= 0;
            temp_value <= 0;
            polarity <= 0;
            digit_1 <= 4'd0;
            digit_2 <= 4'd0;
            digit_3 <= 4'd0;
            digit_4 <= 4'd0;
        end else begin
            case (state)
                0: begin
                    // Set polarity and absolute value of input
                    temp_value <= (value < 0) ? -value : value;
                    polarity <= (value < 0) ? 1 : 0;
                    digit_pos <= 3;
                    state <= 1;
                end
                1: begin
                    // Extract digits from temp_value
                    if (temp_value == 0 && digit_pos == 3) begin // Handle if value == 0
                        digit_1 <= 4'd0;
                        digit_pos <= 1;
                        state <= 0;
                    end else if (temp_value != 0 && digit_pos < 4) begin
                        case (digit_pos)
                            3: digit_4 <= temp_value % 10;
                            2: digit_3 <= temp_value % 10;
                            1: digit_2 <= temp_value % 10;
                            0: digit_1 <= temp_value % 10;
                        endcase
                        temp_value <= temp_value / 10;
                        digit_pos <= digit_pos - 1;
                        if (temp_value == 0) state <= 0;
                    end
                end
            endcase
        end   
    end
endmodule
