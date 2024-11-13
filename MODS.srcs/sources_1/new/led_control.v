module led_control(input clk, input left, input middle, input right, output reg [15:0] led = 0);
    always @ (posedge clk) begin
        led[15:13] = {left, middle, right};
    end
endmodule