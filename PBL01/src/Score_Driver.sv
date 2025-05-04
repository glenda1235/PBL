module Score_Driver(
    input logic clk,
    input logic update,
    input logic [3:0] score,
    output logic [6:0] display
);
    always_comb begin
        case (score)
            4'd0: display = 7'b1000000;
            4'd1: display = 7'b1111001;
            4'd2: display = 7'b0100100;
            4'd3: display = 7'b0110000;
            4'd4: display = 7'b0011001;
            4'd5: display = 7'b0010010;
            4'd6: display = 7'b0000010;
            4'd7: display = 7'b1111000;
            4'd8: display = 7'b0000000;
            4'd9: display = 7'b0011000;
            default: display = 7'b1111111;
        endcase
    end
endmodule