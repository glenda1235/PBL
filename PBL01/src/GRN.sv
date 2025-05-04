module GRN(
    input logic clk,
    input logic rst,
    output logic [1:0] random_out
);
    logic [3:0] lfsr = 4'b1011;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            lfsr <= 4'b1011;
        else
            lfsr <= {lfsr[2:0], lfsr[3] ^ lfsr[1]};
    end

    assign random_out = lfsr[1:0];
endmodule