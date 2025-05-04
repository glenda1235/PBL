module Mux(
    input logic sel_from_grn,
    input logic [1:0] input_grn,
    input logic [1:0] input_player,
    output logic [1:0] mux_out
);
    assign mux_out = (sel_from_grn) ? input_grn : input_player;
endmodule