module Led_Driver(
    input logic clk,
    input logic enable,
    input logic [1:0] sequence,
    output logic [3:0] leds
);
    always_ff @(posedge clk) begin
        if (enable) begin
            leds = 4'b0000;
            leds[sequence] = 1'b1;
        end else begin
            leds = 4'b0000;
        end
    end
endmodule